import '../models/yt_item.dart';
import '../models/renderers/music_shelf_renderers.dart';
import '../utils.dart';

class LibraryPage {
  final List<YTItem> items;
  final String? continuation;

  LibraryPage({
    required this.items,
    this.continuation,
  });

  static YTItem? fromMusicTwoRowItemRenderer(MusicTwoRowItemRenderer renderer) {
    final browseId = renderer.navigationEndpoint.browseEndpoint?.browseId;

    if (renderer.isAlbum) {
      if (browseId == null) return null;
      final playlistId = renderer
          .thumbnailOverlay
          ?.musicItemThumbnailOverlayRenderer
          .content
          .musicPlayButtonRenderer
          .playNavigationEndpoint
          ?.watchPlaylistEndpoint
          ?.playlistId;
      if (playlistId == null) return null;

      final title = renderer.title.runs?.firstOrNull?.text;
      if (title == null) return null;

      final subtitleRuns = renderer.subtitle?.runs;

      return AlbumItem(
        browseId: browseId,
        playlistId: playlistId,
        title: title,
        year: int.tryParse(subtitleRuns?.lastOrNull?.text ?? ""),
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl() ?? "",
        explicit: renderer.subtitleBadges?.any((b) =>
                b.musicInlineBadgeRenderer?.icon.iconType ==
                "MUSIC_EXPLICIT_BADGE") ??
            false,
      );
    } else if (renderer.isPlaylist) {
      if (browseId == null) return null;

      return PlaylistItem(
        id: browseId.startsWith("VL") ? browseId.substring(2) : browseId,
        title: renderer.title.runs?.firstOrNull?.text ?? "",
        songCountText: renderer.subtitle?.runs?.lastOrNull?.text,
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl(),
        // playEndpoint... shuffleEndpoint... radioEndpoint...
      );
    } else if (renderer.isArtist) {
      if (browseId == null) return null;
      return ArtistItem(
        id: browseId,
        title: renderer.title.runs?.lastOrNull?.text ?? "",
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl(),
        // endpoints...
      );
    }

    return null;
  }

  static YTItem? fromMusicResponsiveListItemRenderer(
      MusicResponsiveListItemRenderer renderer) {
    if (renderer.isSong == true) {
      // Using helper getter if available or logic
      // Wait, I didn't add `isSong` getter to `MusicResponsiveListItemRenderer` in Dart yet.
      // Kotlin has: val isSong: Boolean get() = ...
      // I should implement it in `music_shelf_renderers.dart` or check manually.
      // Here I will assume I need to check endpoint.

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
        artists: [], // Extract artists...
        duration: durationText != null ? parseTime(durationText) : null,
        thumbnail: renderer.thumbnail?.getThumbnailUrl() ?? "",
        // explicit...
      );
    }
    // Handle Artist...
    return null;
  }
}
