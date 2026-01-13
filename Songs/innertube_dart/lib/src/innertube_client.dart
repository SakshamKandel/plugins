import 'dart:convert';
import 'package:dio/dio.dart';
import 'utils.dart';
import 'models/context.dart';
import 'models/youtube_locale.dart';
import 'youtube_client.dart';

// Body models
import 'models/body/search_body.dart';
import 'models/body/player_body.dart';
import 'models/body/browse_body.dart';
import 'models/body/next_body.dart';
import 'models/body/feedback_body.dart';
import 'models/body/get_search_suggestions_body.dart';
import 'models/body/get_queue_body.dart';
import 'models/body/get_transcript_body.dart';
import 'models/body/account_menu_body.dart';
import 'models/body/like_body.dart';
import 'models/body/subscribe_body.dart';
import 'models/body/edit_playlist_body.dart';

class InnerTubeClient {
  late Dio _httpClient;

  YouTubeLocale locale = const YouTubeLocale(
    gl: "US", // Default to US, can be updated
    hl: "en-US",
  );

  String? visitorData;
  String? dataSyncId;

  String? _cookie;
  String? get cookie => _cookie;

  Map<String, String> _cookieMap = {};

  set cookie(String? value) {
    _cookie = value;
    _cookieMap = value != null ? parseCookieString(value) : {};
  }

  String? proxy; // Format: "host:port" or "scheme://host:port"
  String? proxyAuth; // Format: "Basic base64encoded"

  bool useLoginForBrowse = false;

  InnerTubeClient() {
    _httpClient = _createClient();
  }

  Dio _createClient() {
    final dio = Dio(BaseOptions(
      baseUrl: YouTubeClient.API_URL_YOUTUBE_MUSIC,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        "Accept": "application/json",
        "Accept-Language": "en-US,en;q=0.9",
        "Cache-Control": "no-cache",
      },
      responseType: ResponseType.json,
    ));

    // Proxy configuration would go here (requires custom HttpClientAdapter for Dio/HttpClient)
    // For simplicity, omitting advanced proxy/custom adapter logic unless requested.

    return dio;
  }

  // Helper to apply client headers
  Options _ytOptions(YouTubeClient client, {bool setLogin = false}) {
    final headers = <String, dynamic>{
      "X-Goog-Api-Format-Version": "1",
      "X-YouTube-Client-Name": client.clientId,
      "X-YouTube-Client-Version": client.clientVersion,
      "X-Origin": YouTubeClient.ORIGIN_YOUTUBE_MUSIC,
      "Referer": YouTubeClient.REFERER_YOUTUBE_MUSIC,
      "User-Agent": client.userAgent,
    };

    if (setLogin && client.loginSupported && _cookie != null) {
      headers["cookie"] = _cookie;
      if (_cookieMap.containsKey("SAPISID")) {
        final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final sapisidHash = sha1(
            "$currentTime ${_cookieMap["SAPISID"]} ${YouTubeClient.ORIGIN_YOUTUBE_MUSIC}");
        headers["Authorization"] = "SAPISIDHASH ${currentTime}_$sapisidHash";
      }
    }

    return Options(headers: headers);
  }

  Future<Response> search(
    YouTubeClient client, {
    String? query,
    String? params,
    String? continuation,
  }) async {
    return _httpClient.post(
      "search",
      data: SearchBody(
        context: client.toContext(
          locale,
          visitorData,
          useLoginForBrowse ? dataSyncId : null,
        ),
        query: query,
        params: params,
      ).toJson(),
      queryParameters: {
        if (continuation != null) "continuation": continuation,
        if (continuation != null) "ctoken": continuation,
      },
      options: _ytOptions(client, setLogin: useLoginForBrowse),
    );
  }

  Future<Response> player(
    YouTubeClient client,
    String videoId, {
    String? playlistId,
    int? signatureTimestamp,
  }) async {
    // Handling isEmbedded logic from Kotlin:
    var context = client.toContext(locale, visitorData, dataSyncId);
    if (client.isEmbedded) {
      // Deep copy needed for immutable modification, simplistic approach here:
      // Dart models are simple classes, we can create a new Context manually or add copyWith methods.
      // For now, creating a new Context with modified ThirdParty.
      context = Context(
        client: context.client,
        user: context.user,
        request: context.request,
        thirdParty: ContextThirdParty(
            embedUrl: "https://www.youtube.com/watch?v=$videoId"),
      );
    }

    PlaybackContext? playbackContext;
    if (client.useSignatureTimestamp && signatureTimestamp != null) {
      playbackContext = PlaybackContext(
          contentPlaybackContext:
              ContentPlaybackContext(signatureTimestamp: signatureTimestamp));
    }

    return _httpClient.post(
      "player",
      data: PlayerBody(
        context: context,
        videoId: videoId,
        playlistId: playlistId,
        playbackContext: playbackContext,
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> registerPlayback(
    String url,
    String cpn, {
    String? playlistId,
    YouTubeClient client = YouTubeClient.WEB_REMIX,
  }) async {
    // Note: url here is likely an absolute URL from the playback tracking, so we might need a separate Dio call or override base url.
    // Dio supports absolute URLs in request path.
    final queryParams = <String, dynamic>{
      "ver": "2",
      "c": client.clientName,
      "cpn": cpn,
    };
    if (playlistId != null) {
      queryParams["list"] = playlistId;
      queryParams["referrer"] =
          "https://music.youtube.com/playlist?list=$playlistId";
    }

    return _httpClient.get(
      url,
      queryParameters: queryParams,
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> browse(
    YouTubeClient client, {
    String? browseId,
    String? params,
    String? continuation,
    bool setLogin = false,
  }) async {
    final useAuth = setLogin || useLoginForBrowse;
    return _httpClient.post(
      "browse",
      data: BrowseBody(
        context: client.toContext(
          locale,
          visitorData,
          useAuth ? dataSyncId : null,
        ),
        browseId: browseId,
        params: params,
        continuation: continuation,
      ).toJson(),
      options: _ytOptions(client, setLogin: useAuth),
    );
  }

  Future<Response> next(
    YouTubeClient client, {
    String? videoId,
    String? playlistId,
    String? playlistSetVideoId,
    int? index,
    String? params,
    String? continuation,
  }) async {
    return _httpClient.post(
      "next",
      data: NextBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        videoId: videoId,
        playlistId: playlistId,
        playlistSetVideoId: playlistSetVideoId,
        index: index,
        params: params,
        continuation: continuation,
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> feedback(
    YouTubeClient client,
    List<String> tokens,
  ) async {
    return _httpClient.post(
      "feedback",
      data: FeedbackBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        feedbackTokens: tokens,
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> getSearchSuggestions(
    YouTubeClient client,
    String input,
  ) async {
    return _httpClient.post(
      "music/get_search_suggestions",
      data: GetSearchSuggestionsBody(
        context: client.toContext(locale, visitorData, null),
        input: input,
      ).toJson(),
      options: _ytOptions(client),
    );
  }

  Future<Response> getQueue(
    YouTubeClient client, {
    List<String>? videoIds,
    String? playlistId,
  }) async {
    return _httpClient.post(
      "music/get_queue",
      data: GetQueueBody(
        context: client.toContext(locale, visitorData, null),
        videoIds: videoIds,
        playlistId: playlistId,
      ).toJson(),
      options: _ytOptions(client),
    );
  }

  Future<Response> getTranscript(
    YouTubeClient client,
    String videoId,
  ) async {
    // Base64 encoding params: "\n" + char(11) + videoId
    final paramsString = "\n${String.fromCharCode(11)}$videoId";
    final paramsBase64 = base64Encode(utf8.encode(paramsString));

    return _httpClient.post(
      "https://music.youtube.com/youtubei/v1/get_transcript",
      queryParameters: {"key": "AIzaSyC9XL3ZjWddXya6X74dJoCTL-WEYFDNX3"},
      data: GetTranscriptBody(
        context: client.toContext(locale, null, null),
        params: paramsBase64,
      ).toJson(),
      options: Options(
        headers: {
          "Content-Type": "application/json",
          ...(_ytOptions(client).headers ??
              {}), // Merge generic headers if needed
        },
      ),
    );
  }

  Future<Response> accountMenu(YouTubeClient client) async {
    return _httpClient.post(
      "account/account_menu",
      data: AccountMenuBody(
        context: client.toContext(locale, visitorData, dataSyncId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> likeVideo(YouTubeClient client, String videoId) async {
    return _httpClient.post(
      "like/like",
      data: LikeBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        target: VideoTarget(videoId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> unlikeVideo(YouTubeClient client, String videoId) async {
    // unlike is actually 'like/removelike'
    return _httpClient.post(
      "like/removelike",
      data: LikeBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        target: VideoTarget(videoId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> subscribeChannel(
      YouTubeClient client, String channelId) async {
    return _httpClient.post(
      "subscription/subscribe",
      data: SubscribeBody(
        channelIds: [channelId],
        context: client.toContext(locale, visitorData, dataSyncId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> unsubscribeChannel(
      YouTubeClient client, String channelId) async {
    return _httpClient.post(
      "subscription/unsubscribe",
      data: SubscribeBody(
        channelIds: [channelId],
        context: client.toContext(locale, visitorData, dataSyncId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> likePlaylist(YouTubeClient client, String playlistId) async {
    return _httpClient.post(
      "like/like",
      data: LikeBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        target: PlaylistTarget(playlistId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> unlikePlaylist(
      YouTubeClient client, String playlistId) async {
    return _httpClient.post(
      "like/removelike",
      data: LikeBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        target: PlaylistTarget(playlistId),
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }

  Future<Response> addToPlaylist(
    YouTubeClient client,
    String playlistId,
    String videoId,
  ) async {
    return _httpClient.post(
      "browse/edit_playlist",
      data: EditPlaylistBody(
        context: client.toContext(locale, visitorData, dataSyncId),
        playlistId:
            playlistId.startsWith("VL") ? playlistId.substring(2) : playlistId,
        actions: [AddVideoAction(addedVideoId: videoId)],
      ).toJson(),
      options: _ytOptions(client, setLogin: true),
    );
  }
}
