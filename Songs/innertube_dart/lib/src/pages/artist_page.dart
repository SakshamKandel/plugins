import '../models/yt_item.dart';
import '../models/renderers/music_shelf_renderers.dart';
import '../models/response/browse_response.dart';
import '../utils.dart';
import 'home_page.dart'; // Reuse HomeSection
import 'search_page.dart'; // Reuse SearchPage.toYTItem

class ArtistSection {
  final String title;
  final List<YTItem> items;
  final String? moreEndpoint; // browseId

  ArtistSection({
    required this.title,
    required this.items,
    this.moreEndpoint,
  });
}

class ArtistPage {
  final ArtistItem artist;
  final List<ArtistSection> sections;
  final String? description;

  ArtistPage({
    required this.artist,
    required this.sections,
    this.description,
  });

  static ArtistPage? fromResponse(BrowseResponse response, String artistId) {
    if (response.contents == null) return null;

    final singleColumn = response.contents!.singleColumnBrowseResultsRenderer;
    final tab = singleColumn?.tabs.firstOrNull?.tabRenderer;
    final sectionList = tab?.content?.sectionListRenderer;

    // Also support TwoColumnBrowseResultsRenderer for web logic if needed, but mainly SingleColumn for mobile API
    // If sectionList is null, maybe TwoColumn?
    final sectionsList = sectionList ??
        response.contents!.twoColumnBrowseResultsRenderer?.secondaryContents
            ?.sectionListRenderer;

    if (sectionsList == null) return null;

    final header = response.header?.musicImmersiveHeaderRenderer;
    final artistName = header?.title.runs?.firstOrNull?.text ?? "";
    final artistThumbnail = header?.thumbnail?.getThumbnailUrl();

    final artistItem = ArtistItem(
      id: artistId, // Passed from caller usually or extracted from header endpoint?
      title: artistName,
      thumbnail: artistThumbnail,
      // shuffleEndpoint...
    );

    final sections = sectionsList.contents
            ?.map((content) {
              if (content.musicCarouselShelfRenderer != null) {
                return fromMusicCarouselShelfRenderer(
                    content.musicCarouselShelfRenderer!);
              } else if (content.musicShelfRenderer != null) {
                return fromMusicShelfRenderer(content.musicShelfRenderer!);
              }
              return null;
            })
            .whereType<ArtistSection>()
            .toList() ??
        [];

    final description = header?.description?.runs?.firstOrNull?.text;

    return ArtistPage(
      artist: artistItem,
      sections: sections,
      description: description,
    );
  }

  static ArtistSection? fromMusicShelfRenderer(MusicShelfRenderer renderer) {
    final items = renderer.contents
        ?.map((c) {
          if (c.musicResponsiveListItemRenderer != null) {
            return SearchPage.toYTItem(c.musicResponsiveListItemRenderer!);
          }
          // Use HomePage logic for TwoRowItem if needed in MusicShelf? (Unlikely)
          return null;
        })
        .whereType<YTItem>()
        .toList();

    if (items == null || items.isEmpty) return null;

    return ArtistSection(
      title: renderer.title?.runs?.firstOrNull?.text ?? "",
      items: items,
      moreEndpoint: renderer.title?.runs?.firstOrNull?.navigationEndpoint
          ?.browseEndpoint?.browseId, // Logic might differ
    );
  }

  static ArtistSection? fromMusicCarouselShelfRenderer(
      MusicCarouselShelfRenderer renderer) {
    final title = renderer.header?.musicCarouselShelfBasicHeaderRenderer.title
        .runs?.firstOrNull?.text;
    if (title == null) return null;

    final items = renderer.contents
        .map((c) {
          if (c.musicTwoRowItemRenderer != null) {
            return HomeSection.fromMusicTwoRowItemRenderer(
                c.musicTwoRowItemRenderer!);
          } else if (c.musicResponsiveListItemRenderer != null) {
            return SearchPage.toYTItem(c.musicResponsiveListItemRenderer!);
          }
          return null;
        })
        .whereType<YTItem>()
        .toList();

    if (items.isEmpty) return null;

    return ArtistSection(
      title: title,
      items: items,
      moreEndpoint: renderer
          .header
          ?.musicCarouselShelfBasicHeaderRenderer
          .moreContentButton
          ?.buttonRenderer
          ?.navigationEndpoint
          ?.browseEndpoint
          ?.browseId,
    );
  }
}
