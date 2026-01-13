import 'endpoint.dart';

abstract class YTItem {
  String get id;
  String get title;
  String? get thumbnail;
  bool get explicit;
  String get shareLink;
}

class Artist {
  final String name;
  final String? id;

  Artist({required this.name, this.id});
}

class Album {
  final String name;
  final String id;

  Album({required this.name, required this.id});
}

class SongItem extends YTItem {
  @override
  final String id;
  @override
  final String title;
  final List<Artist> artists;
  final Album? album;
  final int? duration;
  final String? musicVideoType;
  final int? chartPosition;
  final String? chartChange;
  @override
  final String thumbnail;
  @override
  final bool explicit;
  final WatchEndpoint? endpoint;
  final String? setVideoId;
  final String? libraryAddToken;
  final String? libraryRemoveToken;
  final String? historyRemoveToken;

  SongItem({
    required this.id,
    required this.title,
    required this.artists,
    this.album,
    this.duration,
    this.musicVideoType,
    this.chartPosition,
    this.chartChange,
    required this.thumbnail,
    this.explicit = false,
    this.endpoint,
    this.setVideoId,
    this.libraryAddToken,
    this.libraryRemoveToken,
    this.historyRemoveToken,
  });

  bool get isVideoSong =>
      musicVideoType != null &&
      musicVideoType != WatchEndpointMusicConfig.MUSIC_VIDEO_TYPE_ATV;

  @override
  String get shareLink => "https://music.youtube.com/watch?v=$id";
}

class AlbumItem extends YTItem {
  final String browseId;
  final String playlistId;
  @override
  String get id => browseId;
  @override
  final String title;
  final List<Artist>? artists;
  final int? year;
  @override
  final String thumbnail;
  @override
  final bool explicit;

  AlbumItem({
    required this.browseId,
    required this.playlistId,
    required this.title,
    this.artists,
    this.year,
    required this.thumbnail,
    this.explicit = false,
  });

  @override
  String get shareLink => "https://music.youtube.com/playlist?list=$playlistId";
}

class PlaylistItem extends YTItem {
  @override
  final String id;
  @override
  final String title;
  final Artist? author;
  final String? songCountText;
  @override
  final String? thumbnail;
  final WatchEndpoint? playEndpoint;
  final WatchEndpoint? shuffleEndpoint;
  final WatchEndpoint? radioEndpoint;
  final bool isEditable;

  PlaylistItem({
    required this.id,
    required this.title,
    this.author,
    this.songCountText,
    this.thumbnail,
    this.playEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
    this.isEditable = false,
  });

  @override
  bool get explicit => false;

  @override
  String get shareLink => "https://music.youtube.com/playlist?list=$id";
}

class ArtistItem extends YTItem {
  @override
  final String id;
  @override
  final String title;
  @override
  final String? thumbnail;
  final String? channelId;
  final WatchEndpoint? playEndpoint;
  final WatchEndpoint? shuffleEndpoint;
  final WatchEndpoint? radioEndpoint;

  ArtistItem({
    required this.id,
    required this.title,
    this.thumbnail,
    this.channelId,
    this.playEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
  });

  @override
  bool get explicit => false;

  @override
  String get shareLink => "https://music.youtube.com/channel/$id";
}

extension YTItemListFilter on List<YTItem> {
  List<T> filterExplicit<T extends YTItem>({bool enabled = true}) {
    if (enabled) {
      return whereType<T>().where((it) => !it.explicit).toList();
    } else {
      return cast<T>();
    }
  }

  List<T> filterVideoSongs<T extends YTItem>({bool disableVideos = false}) {
    if (disableVideos) {
      return whereType<T>().where((it) {
        if (it is SongItem && it.isVideoSong) return false;
        return true;
      }).toList();
    } else {
      return cast<T>();
    }
  }
}
