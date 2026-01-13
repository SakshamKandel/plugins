abstract class Endpoint {
  Map<String, dynamic> toJson();
}

class WatchEndpoint extends Endpoint {
  final String? videoId;
  final String? playlistId;
  final String? playlistSetVideoId;
  final String? params;
  final int? index;
  final WatchEndpointMusicSupportedConfigs? watchEndpointMusicSupportedConfigs;

  WatchEndpoint({
    this.videoId,
    this.playlistId,
    this.playlistSetVideoId,
    this.params,
    this.index,
    this.watchEndpointMusicSupportedConfigs,
  });

  factory WatchEndpoint.fromJson(Map<String, dynamic> json) {
    return WatchEndpoint(
      videoId: json['videoId'],
      playlistId: json['playlistId'],
      playlistSetVideoId: json['playlistSetVideoId'],
      params: json['params'],
      index: json['index'],
      watchEndpointMusicSupportedConfigs:
          json['watchEndpointMusicSupportedConfigs'] != null
              ? WatchEndpointMusicSupportedConfigs.fromJson(
                  json['watchEndpointMusicSupportedConfigs'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        if (videoId != null) 'videoId': videoId,
        if (playlistId != null) 'playlistId': playlistId,
        if (playlistSetVideoId != null)
          'playlistSetVideoId': playlistSetVideoId,
        if (params != null) 'params': params,
        if (index != null) 'index': index,
        if (watchEndpointMusicSupportedConfigs != null)
          'watchEndpointMusicSupportedConfigs':
              watchEndpointMusicSupportedConfigs!.toJson(),
      };
}

class WatchEndpointMusicSupportedConfigs {
  final WatchEndpointMusicConfig watchEndpointMusicConfig;

  WatchEndpointMusicSupportedConfigs({
    required this.watchEndpointMusicConfig,
  });

  factory WatchEndpointMusicSupportedConfigs.fromJson(
      Map<String, dynamic> json) {
    return WatchEndpointMusicSupportedConfigs(
      watchEndpointMusicConfig: WatchEndpointMusicConfig.fromJson(
          json['watchEndpointMusicConfig'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'watchEndpointMusicConfig': watchEndpointMusicConfig.toJson(),
      };
}

class WatchEndpointMusicConfig {
  final String musicVideoType;

  WatchEndpointMusicConfig({
    required this.musicVideoType,
  });

  factory WatchEndpointMusicConfig.fromJson(Map<String, dynamic> json) {
    return WatchEndpointMusicConfig(
      musicVideoType: json['musicVideoType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'musicVideoType': musicVideoType,
      };

  static const String MUSIC_VIDEO_TYPE_OMV = "MUSIC_VIDEO_TYPE_OMV";
  static const String MUSIC_VIDEO_TYPE_UGC = "MUSIC_VIDEO_TYPE_UGC";
  static const String MUSIC_VIDEO_TYPE_ATV = "MUSIC_VIDEO_TYPE_ATV";
}

class BrowseEndpoint extends Endpoint {
  final String browseId;
  final String? params;
  final BrowseEndpointContextSupportedConfigs?
      browseEndpointContextSupportedConfigs;

  BrowseEndpoint({
    required this.browseId,
    this.params,
    this.browseEndpointContextSupportedConfigs,
  });

  factory BrowseEndpoint.fromJson(Map<String, dynamic> json) {
    return BrowseEndpoint(
      browseId: json['browseId'] ?? '',
      params: json['params'],
      browseEndpointContextSupportedConfigs:
          json['browseEndpointContextSupportedConfigs'] != null
              ? BrowseEndpointContextSupportedConfigs.fromJson(
                  json['browseEndpointContextSupportedConfigs'])
              : null,
    );
  }

  bool get isArtistEndpoint =>
      browseEndpointContextSupportedConfigs
          ?.browseEndpointContextMusicConfig.pageType ==
      BrowseEndpointContextMusicConfig.MUSIC_PAGE_TYPE_ARTIST;

  bool get isAlbumEndpoint =>
      browseEndpointContextSupportedConfigs
              ?.browseEndpointContextMusicConfig.pageType ==
          BrowseEndpointContextMusicConfig.MUSIC_PAGE_TYPE_ALBUM ||
      browseEndpointContextSupportedConfigs
              ?.browseEndpointContextMusicConfig.pageType ==
          BrowseEndpointContextMusicConfig.MUSIC_PAGE_TYPE_AUDIOBOOK;

  bool get isPlaylistEndpoint =>
      browseEndpointContextSupportedConfigs
          ?.browseEndpointContextMusicConfig.pageType ==
      BrowseEndpointContextMusicConfig.MUSIC_PAGE_TYPE_PLAYLIST;

  @override
  Map<String, dynamic> toJson() => {
        'browseId': browseId,
        if (params != null) 'params': params,
        if (browseEndpointContextSupportedConfigs != null)
          'browseEndpointContextSupportedConfigs':
              browseEndpointContextSupportedConfigs!.toJson(),
      };
}

class BrowseEndpointContextSupportedConfigs {
  final BrowseEndpointContextMusicConfig browseEndpointContextMusicConfig;

  BrowseEndpointContextSupportedConfigs({
    required this.browseEndpointContextMusicConfig,
  });

  factory BrowseEndpointContextSupportedConfigs.fromJson(
      Map<String, dynamic> json) {
    return BrowseEndpointContextSupportedConfigs(
      browseEndpointContextMusicConfig:
          BrowseEndpointContextMusicConfig.fromJson(
              json['browseEndpointContextMusicConfig'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'browseEndpointContextMusicConfig':
            browseEndpointContextMusicConfig.toJson(),
      };
}

class BrowseEndpointContextMusicConfig {
  final String pageType;

  BrowseEndpointContextMusicConfig({
    required this.pageType,
  });

  factory BrowseEndpointContextMusicConfig.fromJson(Map<String, dynamic> json) {
    return BrowseEndpointContextMusicConfig(
      pageType: json['pageType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'pageType': pageType,
      };

  static const String MUSIC_PAGE_TYPE_ALBUM = "MUSIC_PAGE_TYPE_ALBUM";
  static const String MUSIC_PAGE_TYPE_AUDIOBOOK = "MUSIC_PAGE_TYPE_AUDIOBOOK";
  static const String MUSIC_PAGE_TYPE_PLAYLIST = "MUSIC_PAGE_TYPE_PLAYLIST";
  static const String MUSIC_PAGE_TYPE_ARTIST = "MUSIC_PAGE_TYPE_ARTIST";
  static const String MUSIC_PAGE_TYPE_LIBRARY_ARTIST =
      "MUSIC_PAGE_TYPE_LIBRARY_ARTIST";
  static const String MUSIC_PAGE_TYPE_USER_CHANNEL =
      "MUSIC_PAGE_TYPE_USER_CHANNEL";
  static const String MUSIC_PAGE_TYPE_TRACK_LYRICS =
      "MUSIC_PAGE_TYPE_TRACK_LYRICS";
  static const String MUSIC_PAGE_TYPE_TRACK_RELATED =
      "MUSIC_PAGE_TYPE_TRACK_RELATED";
}

class SearchEndpoint extends Endpoint {
  final String? params;
  final String query;

  SearchEndpoint({
    this.params,
    required this.query,
  });

  factory SearchEndpoint.fromJson(Map<String, dynamic> json) {
    return SearchEndpoint(
      params: json['params'],
      query: json['query'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        if (params != null) 'params': params,
        'query': query,
      };
}

class FeedbackEndpoint extends Endpoint {
  final String feedbackToken;

  FeedbackEndpoint({
    required this.feedbackToken,
  });

  factory FeedbackEndpoint.fromJson(Map<String, dynamic> json) {
    return FeedbackEndpoint(
      feedbackToken: json['feedbackToken'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'feedbackToken': feedbackToken,
      };
}

class QueueAddEndpoint extends Endpoint {
  final String queueInsertPosition;
  final QueueTarget queueTarget;

  QueueAddEndpoint({
    required this.queueInsertPosition,
    required this.queueTarget,
  });

  factory QueueAddEndpoint.fromJson(Map<String, dynamic> json) {
    return QueueAddEndpoint(
      queueInsertPosition: json['queueInsertPosition'] ?? '',
      queueTarget: QueueTarget.fromJson(json['queueTarget'] ?? {}),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'queueInsertPosition': queueInsertPosition,
        'queueTarget': queueTarget.toJson(),
      };
}

class QueueTarget {
  final String? videoId;
  final String? playlistId;

  QueueTarget({
    this.videoId,
    this.playlistId,
  });

  factory QueueTarget.fromJson(Map<String, dynamic> json) {
    return QueueTarget(
      videoId: json['videoId'],
      playlistId: json['playlistId'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (videoId != null) 'videoId': videoId,
        if (playlistId != null) 'playlistId': playlistId,
      };
}

class ShareEntityEndpoint extends Endpoint {
  final String serializedShareEntity;

  ShareEntityEndpoint({
    required this.serializedShareEntity,
  });

  factory ShareEntityEndpoint.fromJson(Map<String, dynamic> json) {
    return ShareEntityEndpoint(
      serializedShareEntity: json['serializedShareEntity'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'serializedShareEntity': serializedShareEntity,
      };
}

class DefaultServiceEndpoint extends Endpoint {
  final SubscribeEndpoint? subscribeEndpoint;
  final FeedbackEndpoint? feedbackEndpoint;

  DefaultServiceEndpoint({
    this.subscribeEndpoint,
    this.feedbackEndpoint,
  });

  factory DefaultServiceEndpoint.fromJson(Map<String, dynamic> json) {
    return DefaultServiceEndpoint(
      subscribeEndpoint: json['subscribeEndpoint'] != null
          ? SubscribeEndpoint.fromJson(json['subscribeEndpoint'])
          : null,
      feedbackEndpoint: json['feedbackEndpoint'] != null
          ? FeedbackEndpoint.fromJson(json['feedbackEndpoint'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        if (subscribeEndpoint != null)
          'subscribeEndpoint': subscribeEndpoint!.toJson(),
        if (feedbackEndpoint != null)
          'feedbackEndpoint': feedbackEndpoint!.toJson(),
      };
}

class SubscribeEndpoint extends Endpoint {
  final List<String> channelIds;
  final String? params;

  SubscribeEndpoint({
    required this.channelIds,
    this.params,
  });

  factory SubscribeEndpoint.fromJson(Map<String, dynamic> json) {
    return SubscribeEndpoint(
      channelIds: (json['channelIds'] as List? ?? []).cast<String>(),
      params: json['params'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'channelIds': channelIds,
        if (params != null) 'params': params,
      };
}

class ToggledServiceEndpoint extends Endpoint {
  final FeedbackEndpoint? feedbackEndpoint;

  ToggledServiceEndpoint({
    this.feedbackEndpoint,
  });

  factory ToggledServiceEndpoint.fromJson(Map<String, dynamic> json) {
    return ToggledServiceEndpoint(
      feedbackEndpoint: json['feedbackEndpoint'] != null
          ? FeedbackEndpoint.fromJson(json['feedbackEndpoint'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        if (feedbackEndpoint != null)
          'feedbackEndpoint': feedbackEndpoint!.toJson(),
      };
}
