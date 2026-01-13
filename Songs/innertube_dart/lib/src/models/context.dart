class Context {
  final ContextClient client;
  final ContextThirdParty? thirdParty;
  final ContextRequest request;
  final ContextUser user;

  Context({
    required this.client,
    this.thirdParty,
    this.request = const ContextRequest(),
    this.user = const ContextUser(),
  });

  Map<String, dynamic> toJson() => {
        'client': client.toJson(),
        if (thirdParty != null) 'thirdParty': thirdParty!.toJson(),
        'request': request.toJson(),
        'user': user.toJson(),
      };
}

class ContextClient {
  final String clientName;
  final String clientVersion;
  final String? osName;
  final String? osVersion;
  final String? deviceMake;
  final String? deviceModel;
  final String? androidSdkVersion;
  final String gl;
  final String hl;
  final String? visitorData;

  ContextClient({
    required this.clientName,
    required this.clientVersion,
    this.osName,
    this.osVersion,
    this.deviceMake,
    this.deviceModel,
    this.androidSdkVersion,
    required this.gl,
    required this.hl,
    this.visitorData,
  });

  Map<String, dynamic> toJson() => {
        'clientName': clientName,
        'clientVersion': clientVersion,
        if (osName != null) 'osName': osName,
        if (osVersion != null) 'osVersion': osVersion,
        if (deviceMake != null) 'deviceMake': deviceMake,
        if (deviceModel != null) 'deviceModel': deviceModel,
        if (androidSdkVersion != null) 'androidSdkVersion': androidSdkVersion,
        'gl': gl,
        'hl': hl,
        if (visitorData != null) 'visitorData': visitorData,
      };
}

class ContextThirdParty {
  final String embedUrl;

  ContextThirdParty({required this.embedUrl});

  Map<String, dynamic> toJson() => {
        'embedUrl': embedUrl,
      };
}

class ContextRequest {
  final List<String> internalExperimentFlags;
  final bool useSsl;

  const ContextRequest({
    this.internalExperimentFlags = const [],
    this.useSsl = true,
  });

  Map<String, dynamic> toJson() => {
        'internalExperimentFlags': internalExperimentFlags,
        'useSsl': useSsl,
      };
}

class ContextUser {
  final bool lockedSafetyMode;
  final String? onBehalfOfUser;

  const ContextUser({
    this.lockedSafetyMode = false,
    this.onBehalfOfUser,
  });

  Map<String, dynamic> toJson() => {
        'lockedSafetyMode': lockedSafetyMode,
        if (onBehalfOfUser != null) 'onBehalfOfUser': onBehalfOfUser,
      };
}
