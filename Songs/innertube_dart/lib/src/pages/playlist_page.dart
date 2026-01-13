import '../models/yt_item.dart';
import '../models/renderers/music_shelf_renderers.dart';
import '../models/response/browse_response.dart';
import '../utils.dart';

class PlaylistPage {
  final PlaylistItem playlist;
  final List<SongItem> songs;
  final String? songsContinuation;
  final String? continuation;

  PlaylistPage({
    required this.playlist,
    required this.songs,
    this.songsContinuation,
    this.continuation,
  });

  static PlaylistPage? fromResponse(
      BrowseResponse response, String playlistId) {
    // Parse header for playlist details
    // MusicResponsiveHeaderRenderer?
    // Check BrowseResponse definition I made. It only has MusicImmersiveHeaderRenderer.
    // Need to expand BrowseHeader if needed.

    // Fallback: use generic info.
    final playlistItem = PlaylistItem(
        id: playlistId,
        title: "Unknown Playlist", // Needs header parsing
        thumbnail: null);

    final tabs = response.contents?.singleColumnBrowseResultsRenderer?.tabs ??
        response.contents?.twoColumnBrowseResultsRenderer?.tabs;

    final sectionList =
        tabs?.firstOrNull?.tabRenderer.content?.sectionListRenderer;
    final shelf = sectionList?.contents?.firstOrNull?.musicShelfRenderer;

    if (shelf == null) return null; // Or return empty playlist

    final songs = shelf.contents
            ?.map((c) {
              if (c.musicResponsiveListItemRenderer != null) {
                return fromMusicResponsiveListItemRenderer(
                    c.musicResponsiveListItemRenderer!);
              }
              return null;
            })
            .whereType<SongItem>()
            .toList() ??
        [];

    return PlaylistPage(
        playlist: playlistItem,
        songs: songs,
        songsContinuation: shelf
            .continuations?.firstOrNull?.nextContinuationData?.continuation);
  }

  static SongItem? fromMusicResponsiveListItemRenderer(
      MusicResponsiveListItemRenderer renderer) {
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
      artists: [], // Simplified, need to extract from columns
      thumbnail: renderer.thumbnail?.getThumbnailUrl() ?? "",
      duration: durationText != null ? parseTime(durationText) : null,
      explicit: renderer.badges?.any((b) =>
              b.musicInlineBadgeRenderer?.icon.iconType ==
              "MUSIC_EXPLICIT_BADGE") ??
          false,
      setVideoId: renderer.playlistItemData?.playlistSetVideoId,
    );
  }
}
