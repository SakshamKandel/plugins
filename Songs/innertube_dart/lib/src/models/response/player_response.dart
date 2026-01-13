import '../renderers/general_renderers.dart';

class PlayerResponse {
  final PlayabilityStatus playabilityStatus;
  final PlayerConfig? playerConfig;
  final StreamingData? streamingData;
  final VideoDetails? videoDetails;

  PlayerResponse({
    required this.playabilityStatus,
    this.playerConfig,
    this.streamingData,
    this.videoDetails,
  });

  factory PlayerResponse.fromJson(Map<String, dynamic> json) {
    return PlayerResponse(
      playabilityStatus:
          PlayabilityStatus.fromJson(json['playabilityStatus'] ?? {}),
      playerConfig: json['playerConfig'] != null
          ? PlayerConfig.fromJson(json['playerConfig'])
          : null,
      streamingData: json['streamingData'] != null
          ? StreamingData.fromJson(json['streamingData'])
          : null,
      videoDetails: json['videoDetails'] != null
          ? VideoDetails.fromJson(json['videoDetails'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'playabilityStatus': playabilityStatus.toJson(),
        if (playerConfig != null) 'playerConfig': playerConfig!.toJson(),
        if (streamingData != null) 'streamingData': streamingData!.toJson(),
        if (videoDetails != null) 'videoDetails': videoDetails!.toJson(),
      };
}

class PlayabilityStatus {
  final String status;
  final String? reason;

  PlayabilityStatus({
    required this.status,
    this.reason,
  });

  factory PlayabilityStatus.fromJson(Map<String, dynamic> json) {
    return PlayabilityStatus(
      status: json['status'] ?? '',
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        if (reason != null) 'reason': reason,
      };
}

class PlayerConfig {
  final AudioConfig audioConfig;

  PlayerConfig({required this.audioConfig});

  factory PlayerConfig.fromJson(Map<String, dynamic> json) {
    return PlayerConfig(
      audioConfig: AudioConfig.fromJson(json['audioConfig'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'audioConfig': audioConfig.toJson(),
      };
}

class AudioConfig {
  final double? loudnessDb;
  final double? perceptualLoudnessDb;

  AudioConfig({
    this.loudnessDb,
    this.perceptualLoudnessDb,
  });

  factory AudioConfig.fromJson(Map<String, dynamic> json) {
    return AudioConfig(
      loudnessDb: (json['loudnessDb'] as num?)?.toDouble(),
      perceptualLoudnessDb: (json['perceptualLoudnessDb'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (loudnessDb != null) 'loudnessDb': loudnessDb,
        if (perceptualLoudnessDb != null)
          'perceptualLoudnessDb': perceptualLoudnessDb,
      };
}

class StreamingData {
  final List<Format>? formats;
  final List<Format> adaptiveFormats;
  final int expiresInSeconds;

  StreamingData({
    this.formats,
    required this.adaptiveFormats,
    required this.expiresInSeconds,
  });

  factory StreamingData.fromJson(Map<String, dynamic> json) {
    return StreamingData(
      formats: json['formats'] != null
          ? (json['formats'] as List).map((e) => Format.fromJson(e)).toList()
          : null,
      adaptiveFormats: (json['adaptiveFormats'] as List? ?? [])
          .map((e) => Format.fromJson(e))
          .toList(),
      expiresInSeconds:
          int.tryParse(json['expiresInSeconds']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        if (formats != null)
          'formats': formats!.map((e) => e.toJson()).toList(),
        'adaptiveFormats': adaptiveFormats.map((e) => e.toJson()).toList(),
        'expiresInSeconds': expiresInSeconds,
      };
}

class Format {
  final int itag;
  final String? url;
  final String mimeType;
  final int bitrate;
  final int? width;
  final int? height;
  final int? contentLength;
  final String quality;
  final int? fps;
  final String? qualityLabel;
  final int? averageBitrate;
  final String? audioQuality;
  final String? approxDurationMs;
  final int? audioSampleRate;
  final int? audioChannels;
  final double? loudnessDb;
  final int? lastModified;
  final String? signatureCipher;
  final AudioTrack? audioTrack;

  Format({
    required this.itag,
    this.url,
    required this.mimeType,
    required this.bitrate,
    this.width,
    this.height,
    this.contentLength,
    required this.quality,
    this.fps,
    this.qualityLabel,
    this.averageBitrate,
    this.audioQuality,
    this.approxDurationMs,
    this.audioSampleRate,
    this.audioChannels,
    this.loudnessDb,
    this.lastModified,
    this.signatureCipher,
    this.audioTrack,
  });

  factory Format.fromJson(Map<String, dynamic> json) {
    return Format(
      itag: json['itag'] ?? 0,
      url: json['url'],
      mimeType: json['mimeType'] ?? '',
      bitrate: json['bitrate'] ?? 0,
      width: json['width'],
      height: json['height'],
      contentLength: int.tryParse(json['contentLength']?.toString() ?? ''),
      quality: json['quality'] ?? '',
      fps: json['fps'],
      qualityLabel: json['qualityLabel'],
      averageBitrate: json['averageBitrate'],
      audioQuality: json['audioQuality'],
      approxDurationMs: json['approxDurationMs'],
      audioSampleRate: int.tryParse(json['audioSampleRate']?.toString() ?? ''),
      audioChannels: json['audioChannels'],
      loudnessDb: (json['loudnessDb'] as num?)?.toDouble(),
      lastModified: int.tryParse(json['lastModified']?.toString() ?? ''),
      signatureCipher: json['signatureCipher'],
      audioTrack: json['audioTrack'] != null
          ? AudioTrack.fromJson(json['audioTrack'])
          : null,
    );
  }

  bool get isAudio => width == null;
  bool get isVideo => width != null;

  Map<String, dynamic> toJson() => {
        'itag': itag,
        if (url != null) 'url': url,
        'mimeType': mimeType,
        'bitrate': bitrate,
        if (width != null) 'width': width,
        if (height != null) 'height': height,
        if (contentLength != null) 'contentLength': contentLength,
        'quality': quality,
        if (fps != null) 'fps': fps,
        if (qualityLabel != null) 'qualityLabel': qualityLabel,
        if (averageBitrate != null) 'averageBitrate': averageBitrate,
        if (audioQuality != null) 'audioQuality': audioQuality,
        if (approxDurationMs != null) 'approxDurationMs': approxDurationMs,
        if (audioSampleRate != null) 'audioSampleRate': audioSampleRate,
        if (audioChannels != null) 'audioChannels': audioChannels,
        if (loudnessDb != null) 'loudnessDb': loudnessDb,
        if (lastModified != null) 'lastModified': lastModified,
        if (signatureCipher != null) 'signatureCipher': signatureCipher,
        if (audioTrack != null) 'audioTrack': audioTrack!.toJson(),
      };
}

class AudioTrack {
  final String? displayName;
  final String? id;
  final bool? isAutoDubbed;

  AudioTrack({
    this.displayName,
    this.id,
    this.isAutoDubbed,
  });

  factory AudioTrack.fromJson(Map<String, dynamic> json) {
    return AudioTrack(
      displayName: json['displayName'],
      id: json['id'],
      isAutoDubbed: json['isAutoDubbed'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (displayName != null) 'displayName': displayName,
        if (id != null) 'id': id,
        if (isAutoDubbed != null) 'isAutoDubbed': isAutoDubbed,
      };
}

class VideoDetails {
  final String videoId;
  final String? title;
  final String? author;
  final String channelId;
  final String lengthSeconds;
  final String? musicVideoType;
  final String? viewCount;
  final Thumbnails? thumbnail;

  VideoDetails({
    required this.videoId,
    this.title,
    this.author,
    required this.channelId,
    required this.lengthSeconds,
    this.musicVideoType,
    this.viewCount,
    this.thumbnail,
  });

  factory VideoDetails.fromJson(Map<String, dynamic> json) {
    return VideoDetails(
      videoId: json['videoId'] ?? '',
      title: json['title'],
      author: json['author'],
      channelId: json['channelId'] ?? '',
      lengthSeconds: json['lengthSeconds'] ?? '',
      musicVideoType: json['musicVideoType'],
      viewCount: json['viewCount'],
      thumbnail: json['thumbnail'] != null
          ? Thumbnails.fromJson(json['thumbnail'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'videoId': videoId,
        if (title != null) 'title': title,
        if (author != null) 'author': author,
        'channelId': channelId,
        'lengthSeconds': lengthSeconds,
        if (musicVideoType != null) 'musicVideoType': musicVideoType,
        if (viewCount != null) 'viewCount': viewCount,
        if (thumbnail != null) 'thumbnail': thumbnail!.toJson(),
      };
}
