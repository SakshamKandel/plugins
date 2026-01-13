import '../renderers/music_shelf_renderers.dart';
import '../renderers/general_renderers.dart';
import '../runs.dart';

class BrowseResponse {
  final BrowseResponseContents? contents;
  final ContinuationContents? continuationContents;
  // final List<ResponseAction>? onResponseReceivedActions; // Omitted for brevity
  final BrowseHeader? header;
  // final Microformat? microformat; // Omitted
  // final ResponseContext responseContext; // Omitted
  final ThumbnailRenderer? background;

  BrowseResponse({
    this.contents,
    this.continuationContents,
    this.header,
    this.background,
  });

  factory BrowseResponse.fromJson(Map<String, dynamic> json) {
    return BrowseResponse(
      contents: json['contents'] != null
          ? BrowseResponseContents.fromJson(json['contents'])
          : null,
      continuationContents: json['continuationContents'] != null
          ? ContinuationContents.fromJson(json['continuationContents'])
          : null,
      header:
          json['header'] != null ? BrowseHeader.fromJson(json['header']) : null,
      background: json['background'] != null
          ? ThumbnailRenderer.fromJson(json['background'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (contents != null) 'contents': contents!.toJson(),
        if (continuationContents != null)
          'continuationContents': continuationContents!.toJson(),
        if (header != null) 'header': header!.toJson(),
        if (background != null) 'background': background!.toJson(),
      };
}

class BrowseResponseContents {
  final Tabs? singleColumnBrowseResultsRenderer;
  final SectionListRenderer? sectionListRenderer;
  final TwoColumnBrowseResultsRenderer? twoColumnBrowseResultsRenderer;

  BrowseResponseContents({
    this.singleColumnBrowseResultsRenderer,
    this.sectionListRenderer,
    this.twoColumnBrowseResultsRenderer,
  });

  factory BrowseResponseContents.fromJson(Map<String, dynamic> json) {
    return BrowseResponseContents(
      singleColumnBrowseResultsRenderer:
          json['singleColumnBrowseResultsRenderer'] != null
              ? Tabs.fromJson(json['singleColumnBrowseResultsRenderer'])
              : null,
      sectionListRenderer: json['sectionListRenderer'] != null
          ? SectionListRenderer.fromJson(json['sectionListRenderer'])
          : null,
      twoColumnBrowseResultsRenderer:
          json['twoColumnBrowseResultsRenderer'] != null
              ? TwoColumnBrowseResultsRenderer.fromJson(
                  json['twoColumnBrowseResultsRenderer'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (singleColumnBrowseResultsRenderer != null)
          'singleColumnBrowseResultsRenderer':
              singleColumnBrowseResultsRenderer!.toJson(),
        if (sectionListRenderer != null)
          'sectionListRenderer': sectionListRenderer!.toJson(),
        if (twoColumnBrowseResultsRenderer != null)
          'twoColumnBrowseResultsRenderer':
              twoColumnBrowseResultsRenderer!.toJson(),
      };
}

class TwoColumnBrowseResultsRenderer {
  final List<Tab?>? tabs;
  final SecondaryContents? secondaryContents;

  TwoColumnBrowseResultsRenderer({
    this.tabs,
    this.secondaryContents,
  });

  factory TwoColumnBrowseResultsRenderer.fromJson(Map<String, dynamic> json) {
    return TwoColumnBrowseResultsRenderer(
      tabs: json['tabs'] != null
          ? (json['tabs'] as List)
              .map((e) => e != null ? Tab.fromJson(e) : null)
              .toList()
          : null,
      secondaryContents: json['secondaryContents'] != null
          ? SecondaryContents.fromJson(json['secondaryContents'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (tabs != null) 'tabs': tabs!.map((e) => e?.toJson()).toList(),
        if (secondaryContents != null)
          'secondaryContents': secondaryContents!.toJson(),
      };
}

class SecondaryContents {
  final SectionListRenderer? sectionListRenderer;

  SecondaryContents({this.sectionListRenderer});

  factory SecondaryContents.fromJson(Map<String, dynamic> json) {
    return SecondaryContents(
      sectionListRenderer: json['sectionListRenderer'] != null
          ? SectionListRenderer.fromJson(json['sectionListRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (sectionListRenderer != null)
          'sectionListRenderer': sectionListRenderer!.toJson(),
      };
}

class ContinuationContents {
  final SectionListContinuation? sectionListContinuation;
  // final MusicPlaylistShelfContinuation? musicPlaylistShelfContinuation; // Omitted
  // final GridContinuation? gridContinuation; // Omitted
  final MusicShelfRenderer? musicShelfContinuation;

  ContinuationContents({
    this.sectionListContinuation,
    this.musicShelfContinuation,
  });

  factory ContinuationContents.fromJson(Map<String, dynamic> json) {
    return ContinuationContents(
      sectionListContinuation: json['sectionListContinuation'] != null
          ? SectionListContinuation.fromJson(json['sectionListContinuation'])
          : null,
      musicShelfContinuation: json['musicShelfContinuation'] != null
          ? MusicShelfRenderer.fromJson(json['musicShelfContinuation'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (sectionListContinuation != null)
          'sectionListContinuation': sectionListContinuation!.toJson(),
        if (musicShelfContinuation != null)
          'musicShelfContinuation': musicShelfContinuation!.toJson(),
      };
}

class SectionListContinuation {
  final List<SectionListContent> contents;
  final List<Continuation>? continuations;

  SectionListContinuation({
    required this.contents,
    this.continuations,
  });

  factory SectionListContinuation.fromJson(Map<String, dynamic> json) {
    return SectionListContinuation(
      contents: (json['contents'] as List? ?? [])
          .map((e) => SectionListContent.fromJson(e))
          .toList(),
      continuations: json['continuations'] != null
          ? (json['continuations'] as List)
              .map((e) => Continuation.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'contents': contents.map((e) => e.toJson()).toList(),
        if (continuations != null)
          'continuations': continuations!.map((e) => e.toJson()).toList(),
      };
}

class BrowseHeader {
  final MusicImmersiveHeaderRenderer? musicImmersiveHeaderRenderer;
  // Others omitted for brevity

  BrowseHeader({this.musicImmersiveHeaderRenderer});

  factory BrowseHeader.fromJson(Map<String, dynamic> json) {
    return BrowseHeader(
      musicImmersiveHeaderRenderer: json['musicImmersiveHeaderRenderer'] != null
          ? MusicImmersiveHeaderRenderer.fromJson(
              json['musicImmersiveHeaderRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (musicImmersiveHeaderRenderer != null)
          'musicImmersiveHeaderRenderer':
              musicImmersiveHeaderRenderer!.toJson(),
      };
}

class MusicImmersiveHeaderRenderer {
  final Runs title;
  final Runs? description;
  final ThumbnailRenderer? thumbnail;
  final Button? playButton;
  final Button? startRadioButton;
  final Menu menu;

  MusicImmersiveHeaderRenderer({
    required this.title,
    this.description,
    this.thumbnail,
    this.playButton,
    this.startRadioButton,
    required this.menu,
  });

  factory MusicImmersiveHeaderRenderer.fromJson(Map<String, dynamic> json) {
    return MusicImmersiveHeaderRenderer(
      title: Runs.fromJson(json['title'] ?? {}),
      description: json['description'] != null
          ? Runs.fromJson(json['description'])
          : null,
      thumbnail: json['thumbnail'] != null
          ? ThumbnailRenderer.fromJson(json['thumbnail'])
          : null,
      playButton: json['playButton'] != null
          ? Button.fromJson(json['playButton'])
          : null,
      startRadioButton: json['startRadioButton'] != null
          ? Button.fromJson(json['startRadioButton'])
          : null,
      menu: Menu.fromJson(json['menu'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title.toJson(),
        if (description != null) 'description': description!.toJson(),
        if (thumbnail != null) 'thumbnail': thumbnail!.toJson(),
        if (playButton != null) 'playButton': playButton!.toJson(),
        if (startRadioButton != null)
          'startRadioButton': startRadioButton!.toJson(),
        'menu': menu.toJson(),
      };
}
