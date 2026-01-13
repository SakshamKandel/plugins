import 'models/youtube_locale.dart';
import 'models/context.dart';

class YouTubeClient {
  final String clientName;
  final String clientVersion;
  final String clientId;
  final String userAgent;
  final String? osName;
  final String? osVersion;
  final String? deviceMake;
  final String? deviceModel;
  final String? androidSdkVersion;
  final String? buildId;
  final String? cronetVersion;
  final String? packageName;
  final String? friendlyName;
  final bool loginSupported;
  final bool loginRequired;
  final bool useSignatureTimestamp;
  final bool isEmbedded;

  const YouTubeClient({
    required this.clientName,
    required this.clientVersion,
    required this.clientId,
    required this.userAgent,
    this.osName,
    this.osVersion,
    this.deviceMake,
    this.deviceModel,
    this.androidSdkVersion,
    this.buildId,
    this.cronetVersion,
    this.packageName,
    this.friendlyName,
    this.loginSupported = false,
    this.loginRequired = false,
    this.useSignatureTimestamp = false,
    this.isEmbedded = false,
  });

  Context toContext(
      YouTubeLocale locale, String? visitorData, String? dataSyncId) {
    return Context(
      client: ContextClient(
        clientName: clientName,
        clientVersion: clientVersion,
        osName: osName,
        osVersion: osVersion,
        deviceMake: deviceMake,
        deviceModel: deviceModel,
        androidSdkVersion: androidSdkVersion,
        gl: locale.gl,
        hl: locale.hl,
        visitorData: visitorData,
      ),
      user: ContextUser(
        onBehalfOfUser: loginSupported ? dataSyncId : null,
      ),
    );
  }

  static const String USER_AGENT_WEB =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101 Firefox/128.0";

  static const String ORIGIN_YOUTUBE_MUSIC = "https://music.youtube.com";
  static const String REFERER_YOUTUBE_MUSIC = "$ORIGIN_YOUTUBE_MUSIC/";
  static const String API_URL_YOUTUBE_MUSIC =
      "$ORIGIN_YOUTUBE_MUSIC/youtubei/v1/";

  static const YouTubeClient WEB = YouTubeClient(
    clientName: "WEB",
    clientVersion: "2.20251227.00.00",
    clientId: "1",
    userAgent: USER_AGENT_WEB,
  );

  static const YouTubeClient WEB_REMIX = YouTubeClient(
    clientName: "WEB_REMIX",
    clientVersion: "1.20251227.01.00",
    clientId: "67",
    userAgent: USER_AGENT_WEB,
    loginSupported: true,
    useSignatureTimestamp: true,
  );

  static const YouTubeClient WEB_CREATOR = YouTubeClient(
    clientName: "WEB_CREATOR",
    clientVersion: "1.20251227.00.00",
    clientId: "62",
    userAgent: USER_AGENT_WEB,
    loginSupported: true,
    loginRequired: true,
    useSignatureTimestamp: true,
  );

  static const YouTubeClient TVHTML5 = YouTubeClient(
    clientName: "TVHTML5",
    clientVersion: "7.20251227.00.00",
    clientId: "7",
    userAgent:
        "Mozilla/5.0(SMART-TV; Linux; Tizen 4.0.0.2) AppleWebkit/605.1.15 (KHTML, like Gecko) SamsungBrowser/9.2 TV Safari/605.1.15",
    loginSupported: true,
    loginRequired: true,
    useSignatureTimestamp: true,
  );

  static const YouTubeClient TVHTML5_SIMPLY_EMBEDDED_PLAYER = YouTubeClient(
    clientName: "TVHTML5_SIMPLY_EMBEDDED_PLAYER",
    clientVersion: "2.0",
    clientId: "85",
    userAgent:
        "Mozilla/5.0 (PlayStation; PlayStation 4/12.02) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Safari/605.1.15",
    loginSupported: true,
    loginRequired: true,
    useSignatureTimestamp: true,
    isEmbedded: true,
  );

  static const YouTubeClient IOS = YouTubeClient(
    clientName: "IOS",
    clientVersion: "20.51.39",
    clientId: "5",
    userAgent:
        "com.google.ios.youtube/20.51.39 (iPhone16,2; U; CPU iOS 18_2 like Mac OS X;)",
    osVersion: "18.2.22C152",
  );

  static const YouTubeClient MOBILE = YouTubeClient(
    clientName: "ANDROID",
    clientVersion: "20.51.39",
    clientId: "3",
    userAgent:
        "com.google.android.youtube/20.51.39 (Linux; U; Android 14) gzip",
    loginSupported: true,
    useSignatureTimestamp: true,
  );

  static const YouTubeClient ANDROID_VR_NO_AUTH = YouTubeClient(
    clientName: "ANDROID_VR",
    clientVersion: "1.61.48",
    clientId: "28",
    userAgent:
        "com.google.android.apps.youtube.vr.oculus/1.61.48 (Linux; U; Android 12; en_US; Oculus Quest 3; Build/SQ3A.220605.009.A1; Cronet/132.0.6808.3)",
    loginSupported: false,
    useSignatureTimestamp: false,
  );

  static const YouTubeClient ANDROID_VR_1_61_48 = YouTubeClient(
    clientName: "ANDROID_VR",
    clientVersion: "1.61.48",
    clientId: "28",
    userAgent:
        "com.google.android.apps.youtube.vr.oculus/1.61.48 (Linux; U; Android 12; en_US; Quest 3; Build/SQ3A.220605.009.A1; Cronet/132.0.6808.3)",
    osName: "Android",
    osVersion: "12",
    deviceMake: "Oculus",
    deviceModel: "Quest 3",
    androidSdkVersion: "32",
    buildId: "SQ3A.220605.009.A1",
    cronetVersion: "132.0.6808.3",
    packageName: "com.google.android.apps.youtube.vr.oculus",
    friendlyName: "Android VR 1.61",
    loginSupported: false,
    useSignatureTimestamp: false,
  );
}
