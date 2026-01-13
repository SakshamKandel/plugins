import '../models/yt_item.dart';
import '../models/response/browse_response.dart';
import '../models/renderers/music_shelf_renderers.dart';
import '../utils.dart';

class HomePage {
  final List<HomeChip>? chips;
  final List<HomeSection> sections;
  final String? continuation;

  HomePage({
    this.chips,
    required this.sections,
    this.continuation,
  });

  static HomePage? fromResponse(BrowseResponse response) {
    if (response.contents == null) return null;

    final singleColumn = response.contents!.singleColumnBrowseResultsRenderer;
    final tab = singleColumn?.tabs.firstOrNull?.tabRenderer;
    final sectionList = tab?.content?.sectionListRenderer;

    if (sectionList == null) return null;

    final chips = sectionList.header?.chipCloudRenderer?.chips
        .map((e) => HomeChip(
            title: e.chipCloudChipRenderer.text?.runs?.firstOrNull?.text ?? "",
            endpoint: e.chipCloudChipRenderer.navigationEndpoint.browseEndpoint
                ?.browseId,
            deselectEndpoint: e.chipCloudChipRenderer.onDeselectedCommand
                ?.browseEndpoint?.browseId))
        .toList();

    final sections = sectionList.contents
            ?.map((content) {
              if (content.musicCarouselShelfRenderer != null) {
                return HomeSection.fromMusicCarouselShelfRenderer(
                    content.musicCarouselShelfRenderer!);
              }
              // Add filtering for other renderers if needed later
              return null;
            })
            .whereType<HomeSection>() // Filter out nulls
            .toList() ??
        [];

    final continuation = sectionList
        .continuations?.firstOrNull?.nextContinuationData?.continuation;

    return HomePage(
        chips: chips, sections: sections, continuation: continuation);
  }
}

class HomeChip {
  final String title;
  final String? endpoint; // BrowseId
  final String? deselectEndpoint; // BrowseId

  HomeChip({
    required this.title,
    this.endpoint,
    this.deselectEndpoint,
  });
}

class HomeSection {
  final String title;
  final String? label;
  final String? thumbnail;
  final String? endpoint; // BrowseId
  final List<YTItem> items;

  HomeSection({
    required this.title,
    this.label,
    this.thumbnail,
    this.endpoint,
    required this.items,
  });

  static HomeSection? fromMusicCarouselShelfRenderer(
      MusicCarouselShelfRenderer renderer) {
    final title = renderer.header?.musicCarouselShelfBasicHeaderRenderer.title
        .runs?.firstOrNull?.text;
    if (title == null) return null;

    final items = renderer.contents
        .map((content) {
          if (content.musicTwoRowItemRenderer != null) {
            return fromMusicTwoRowItemRenderer(
                content.musicTwoRowItemRenderer!);
          } else if (content.musicResponsiveListItemRenderer != null) {
            return fromMusicResponsiveListItemRenderer(
                content.musicResponsiveListItemRenderer!);
          }
          return null;
        })
        .whereType<YTItem>()
        .toList();

    if (items.isEmpty) return null;

    return HomeSection(
      title: title,
      label: renderer.header?.musicCarouselShelfBasicHeaderRenderer.strapline
          ?.runs?.firstOrNull?.text,
      thumbnail: renderer
          .header?.musicCarouselShelfBasicHeaderRenderer.thumbnail
          ?.getThumbnailUrl(),
      endpoint: renderer
          .header
          ?.musicCarouselShelfBasicHeaderRenderer
          .moreContentButton
          ?.buttonRenderer
          ?.navigationEndpoint
          ?.browseEndpoint
          ?.browseId,
      items: items,
    );
  }

  static YTItem? fromMusicResponsiveListItemRenderer(
      MusicResponsiveListItemRenderer renderer) {
    if (renderer.isSong) {
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

      return SongItem(
        id: videoId,
        title: title ?? "",
        artists: const [],
        thumbnail: renderer.thumbnail?.getThumbnailUrl() ?? "",
        // artists...
      );
    }
    return null;
  }

  static YTItem? fromMusicTwoRowItemRenderer(MusicTwoRowItemRenderer renderer) {
    if (renderer.isSong) {
      final videoId = renderer.navigationEndpoint.anyWatchEndpoint?.videoId;
      if (videoId == null) return null;

      final title = renderer.title.runs?.firstOrNull?.text;
      if (title == null) return null;

      final subtitleRuns = renderer.subtitle?.runs;
      List<Artist> artists = [];
      Album? album;

      if (subtitleRuns != null) {
        for (var run in subtitleRuns) {
          final browseId = run.navigationEndpoint?.browseEndpoint?.browseId;
          // Check for album browse ID pattern or context
          if (browseId != null &&
              (browseId.startsWith("MPREb_") || browseId.startsWith("MREL"))) {
            // MPREb is typical for albums
            album = Album(name: run.text, id: browseId);
          } else if (run.text != " • ") {
            if (browseId != null && browseId.startsWith("UC")) {
              artists.add(Artist(name: run.text, id: browseId));
            } else {
              // Even without ID, if it's text, it might be an artist name
              // But without ID we can't do much.
              if (browseId != null)
                artists.add(Artist(id: browseId, name: run.text));
            }
          }
        }
      }

      return SongItem(
        id: videoId,
        title: title,
        artists: artists,
        album: album,
        musicVideoType: renderer.musicVideoType,
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl() ?? "",
        explicit: renderer.subtitleBadges?.any((b) =>
                b.musicInlineBadgeRenderer?.icon.iconType ==
                "MUSIC_EXPLICIT_BADGE") ??
            false,
      );
    } else if (renderer.isAlbum) {
      final browseId = renderer.navigationEndpoint.browseEndpoint?.browseId;
      if (browseId == null) return null;

      final playlistId = renderer
          .thumbnailOverlay
          ?.musicItemThumbnailOverlayRenderer
          .content
          .musicPlayButtonRenderer
          .playNavigationEndpoint
          ?.anyWatchEndpoint
          ?.playlistId;
      // Allow album without playlistId? Usually needed for playback.
      // If null, return null.
      if (playlistId == null) return null;

      final title = renderer.title.runs?.firstOrNull?.text;

      return AlbumItem(
        browseId: browseId,
        playlistId: playlistId,
        title: title ?? "",
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl() ?? "",
        explicit: renderer.subtitleBadges?.any((b) =>
                b.musicInlineBadgeRenderer?.icon.iconType ==
                "MUSIC_EXPLICIT_BADGE") ??
            false,
      );
    } else if (renderer.isPlaylist) {
      final browseId = renderer.navigationEndpoint.browseEndpoint?.browseId;
      if (browseId == null) return null;

      return PlaylistItem(
        id: browseId.startsWith("VL") ? browseId.substring(2) : browseId,
        title: renderer.title.runs?.firstOrNull?.text ?? "",
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl(),
      );
    } else if (renderer.isArtist) {
      final browseId = renderer.navigationEndpoint.browseEndpoint?.browseId;
      if (browseId == null) return null;

      return ArtistItem(
        id: browseId,
        title: renderer.title.runs?.lastOrNull?.text ?? "",
        thumbnail: renderer.thumbnailRenderer.getThumbnailUrl(),
      );
    }

    return null;
  }
}
