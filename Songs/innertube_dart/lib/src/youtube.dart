import 'innertube_client.dart';
import 'youtube_client.dart';
import 'models/response/browse_response.dart';
import 'models/response/search_response.dart';
import 'pages/search_page.dart';
import 'pages/home_page.dart';
import 'pages/artist_page.dart';
import 'pages/album_page.dart';
import 'pages/playlist_page.dart';

class YouTube {
  final InnerTubeClient innerTube;
  final YouTubeClient apiClient;

  YouTube({InnerTubeClient? innerTube, YouTubeClient? apiClient})
      : innerTube = innerTube ?? InnerTubeClient(),
        apiClient = apiClient ?? YouTubeClient.WEB_REMIX;

  // --- Search ---
  Future<SearchResult?> search(String query) async {
    final response = await innerTube.search(
      apiClient,
      query: query,
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) return null;
    return SearchPage.fromResponse(SearchResponse.fromJson(data));
  }

  // --- Home ---
  Future<HomePage?> fromHome() async {
    final response = await innerTube.browse(
      apiClient,
      browseId: "FEmusic_home",
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) return null;
    return HomePage.fromResponse(BrowseResponse.fromJson(data));
  }

  // --- Artist ---
  Future<ArtistPage?> artist(String artistId) async {
    final response = await innerTube.browse(
      apiClient,
      browseId: artistId,
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) return null;
    return ArtistPage.fromResponse(BrowseResponse.fromJson(data), artistId);
  }

  // --- Album ---
  Future<AlbumPage?> album(String albumId) async {
    final response = await innerTube.browse(
      apiClient,
      browseId: albumId,
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) return null;
    return AlbumPage.fromResponse(BrowseResponse.fromJson(data), albumId);
  }

  // --- Playlist ---
  Future<PlaylistPage?> playlist(String playlistId) async {
    // Playlist ID usually starts with VL if passed from some links, InnerTube expects VL?
    // Or usually InnerTube browsing uses VL + ID.
    // Safe to ensure VL prefix for browse.
    final browseId = playlistId.startsWith("VL") ? playlistId : "VL$playlistId";

    final response = await innerTube.browse(
      apiClient,
      browseId: browseId,
    );

    final data = response.data;
    if (data is! Map<String, dynamic>) return null;
    return PlaylistPage.fromResponse(BrowseResponse.fromJson(data), playlistId);
  }
}
