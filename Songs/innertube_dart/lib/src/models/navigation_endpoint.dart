import 'endpoint.dart';

class NavigationEndpoint {
  final WatchEndpoint? watchEndpoint;
  final WatchEndpoint? watchPlaylistEndpoint;
  final BrowseEndpoint? browseEndpoint;
  final SearchEndpoint? searchEndpoint;
  final QueueAddEndpoint? queueAddEndpoint;
  final ShareEntityEndpoint? shareEntityEndpoint;
  final FeedbackEndpoint? feedbackEndpoint;

  NavigationEndpoint({
    this.watchEndpoint,
    this.watchPlaylistEndpoint,
    this.browseEndpoint,
    this.searchEndpoint,
    this.queueAddEndpoint,
    this.shareEntityEndpoint,
    this.feedbackEndpoint,
  });

  factory NavigationEndpoint.fromJson(Map<String, dynamic> json) {
    return NavigationEndpoint(
      watchEndpoint: json['watchEndpoint'] != null
          ? WatchEndpoint.fromJson(json['watchEndpoint'])
          : null,
      watchPlaylistEndpoint: json['watchPlaylistEndpoint'] != null
          ? WatchEndpoint.fromJson(json['watchPlaylistEndpoint'])
          : null,
      browseEndpoint: json['browseEndpoint'] != null
          ? BrowseEndpoint.fromJson(json['browseEndpoint'])
          : null,
      searchEndpoint: json['searchEndpoint'] != null
          ? SearchEndpoint.fromJson(json['searchEndpoint'])
          : null,
      queueAddEndpoint: json['queueAddEndpoint'] != null
          ? QueueAddEndpoint.fromJson(json['queueAddEndpoint'])
          : null,
      shareEntityEndpoint: json['shareEntityEndpoint'] != null
          ? ShareEntityEndpoint.fromJson(json['shareEntityEndpoint'])
          : null,
      feedbackEndpoint: json['feedbackEndpoint'] != null
          ? FeedbackEndpoint.fromJson(json['feedbackEndpoint'])
          : null,
    );
  }

  Endpoint? get endpoint =>
      watchEndpoint ??
      watchPlaylistEndpoint ??
      browseEndpoint ??
      searchEndpoint ??
      queueAddEndpoint ??
      shareEntityEndpoint;

  WatchEndpoint? get anyWatchEndpoint => watchEndpoint ?? watchPlaylistEndpoint;

  String? get musicVideoType => anyWatchEndpoint
      ?.watchEndpointMusicSupportedConfigs
      ?.watchEndpointMusicConfig
      .musicVideoType;

  Map<String, dynamic> toJson() => {
        if (watchEndpoint != null) 'watchEndpoint': watchEndpoint!.toJson(),
        if (watchPlaylistEndpoint != null)
          'watchPlaylistEndpoint': watchPlaylistEndpoint!.toJson(),
        if (browseEndpoint != null) 'browseEndpoint': browseEndpoint!.toJson(),
        if (searchEndpoint != null) 'searchEndpoint': searchEndpoint!.toJson(),
        if (queueAddEndpoint != null)
          'queueAddEndpoint': queueAddEndpoint!.toJson(),
        if (shareEntityEndpoint != null)
          'shareEntityEndpoint': shareEntityEndpoint!.toJson(),
        if (feedbackEndpoint != null)
          'feedbackEndpoint': feedbackEndpoint!.toJson(),
      };
}
