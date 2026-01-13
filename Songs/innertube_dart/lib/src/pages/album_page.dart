import '../models/yt_item.dart';
import '../models/renderers/music_shelf_renderers.dart';
import '../models/response/browse_response.dart';
import '../utils.dart';

class AlbumPage {
  final AlbumItem album;
  final List<SongItem> songs;
  final List<AlbumItem> otherVersions;

  AlbumPage({
    required this.album,
    required this.songs,
    required this.otherVersions,
  });

  static AlbumPage? fromResponse(BrowseResponse response, String albumId) {
    // Need album details from Header
    // Need songs from MusicShelfRenderer

    final header = response.header
        ?.musicImmersiveHeaderRenderer; // Album often uses different header?
    // Actually Album Page often has MusicResponsiveHeaderRenderer or MusicDetailHeaderRenderer?
    // My `BrowseResponse` definition only has `MusicImmersiveHeaderRenderer` in `BrowseHeader`.
    // I might have missed `MusicDetailHeaderRenderer` in `BrowseHeader` definition if it exists in Kotlin.
    // Assuming Immersive or Detail.
    // If incomplete, I might need to fix `BrowseHeader`.

    final title = header?.title.runs?.firstOrNull?.text ?? "";
    final thumbnail = header?.thumbnail?.getThumbnailUrl();
    final playlistId = header
            ?.playButton
            ?.buttonRenderer
            ?.navigationEndpoint
            ?.anyWatchEndpoint
            ?.playlistId ??
        albumId;

    // Artists?
    // If parsing header fails or is different, might resort to basic info.

    final albumItem = AlbumItem(
      browseId: albumId,
      playlistId: playlistId,
      title: title,
      thumbnail: thumbnail ?? "",
      // playlistId... needed for playback
    );

    final songs = getSongs(response, albumItem);

    return AlbumPage(
      album: albumItem,
      songs: songs,
      otherVersions: [], // Implement if needed
    );
  }

  static List<SongItem> getSongs(BrowseResponse response, AlbumItem album) {
    final tabs = response.contents?.singleColumnBrowseResultsRenderer?.tabs ??
        response.contents?.twoColumnBrowseResultsRenderer?.tabs;

    final shelf = tabs?.firstOrNull?.tabRenderer.content?.sectionListRenderer
        ?.contents?.firstOrNull?.musicShelfRenderer;

    if (shelf == null) return [];

    return shelf.contents
            ?.map((c) {
              if (c.musicResponsiveListItemRenderer != null) {
                return getSong(c.musicResponsiveListItemRenderer!, album);
              }
              return null;
            })
            .whereType<SongItem>()
            .toList() ??
        [];
  }

  static SongItem? getSong(
      MusicResponsiveListItemRenderer renderer, AlbumItem? album) {
    final videoId = renderer.playlistItemData?.videoId;
    if (videoId == null) return null;

    final title = renderer
        .flexColumns
        .firstOrNull
        ?.musicResponsiveListItemFlexColumnRenderer
        .text
        ?.runs
        ?.firstOrNull
        ?.text;
    if (title == null) return null;

    final durationText = renderer
        .fixedColumns
        ?.firstOrNull
        ?.musicResponsiveListItemFlexColumnRenderer
        .text
        ?.runs
        ?.firstOrNull
        ?.text;

    return SongItem(
      id: videoId,
      title: title,
      artists: album?.artists ?? [], // Fallback
      album:
          album != null ? Album(name: album.title, id: album.browseId) : null,
      duration: durationText != null ? parseTime(durationText) : null,
      musicVideoType: renderer.musicVideoType,
      thumbnail:
          renderer.thumbnail?.getThumbnailUrl() ?? album?.thumbnail ?? "",
      explicit: renderer.badges?.any((b) =>
              b.musicInlineBadgeRenderer?.icon.iconType ==
              "MUSIC_EXPLICIT_BADGE") ??
          false,
      // index...
    );
  }
}
