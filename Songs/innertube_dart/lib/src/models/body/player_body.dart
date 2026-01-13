import '../context.dart';

class PlayerBody {
  final Context context;
  final String videoId;
  final String? playlistId;
  final PlaybackContext? playbackContext;
  final ServiceIntegrityDimensions? serviceIntegrityDimensions;
  final bool contentCheckOk;
  final bool racyCheckOk;

  const PlayerBody({
    required this.context,
    required this.videoId,
    this.playlistId,
    this.playbackContext,
    this.serviceIntegrityDimensions,
    this.contentCheckOk = true,
    this.racyCheckOk = true,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'videoId': videoId,
        if (playlistId != null) 'playlistId': playlistId,
        if (playbackContext != null)
          'playbackContext': playbackContext!.toJson(),
        if (serviceIntegrityDimensions != null)
          'serviceIntegrityDimensions': serviceIntegrityDimensions!.toJson(),
        'contentCheckOk': contentCheckOk,
        'racyCheckOk': racyCheckOk,
      };
}

class PlaybackContext {
  final ContentPlaybackContext contentPlaybackContext;

  const PlaybackContext({required this.contentPlaybackContext});

  Map<String, dynamic> toJson() => {
        'contentPlaybackContext': contentPlaybackContext.toJson(),
      };
}

class ContentPlaybackContext {
  final int signatureTimestamp;

  const ContentPlaybackContext({required this.signatureTimestamp});

  Map<String, dynamic> toJson() => {
        'signatureTimestamp': signatureTimestamp,
      };
}

class ServiceIntegrityDimensions {
  final String poToken;

  const ServiceIntegrityDimensions({required this.poToken});

  Map<String, dynamic> toJson() => {
        'poToken': poToken,
      };
}
