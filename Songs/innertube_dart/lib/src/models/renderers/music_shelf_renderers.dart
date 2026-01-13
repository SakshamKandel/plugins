import '../navigation_endpoint.dart';
import '../runs.dart';
import 'general_renderers.dart';

// --- Common Wrappers ---
class Button {
  final ButtonRenderer? buttonRenderer;

  Button({this.buttonRenderer});

  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      buttonRenderer: json['buttonRenderer'] != null
          ? ButtonRenderer.fromJson(json['buttonRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (buttonRenderer != null) 'buttonRenderer': buttonRenderer!.toJson(),
      };
}

class ButtonRenderer {
  final Runs text;
  final NavigationEndpoint? navigationEndpoint;
  final NavigationEndpoint? command;
  final Icon? icon;

  ButtonRenderer({
    required this.text,
    this.navigationEndpoint,
    this.command,
    this.icon,
  });

  factory ButtonRenderer.fromJson(Map<String, dynamic> json) {
    return ButtonRenderer(
      text: Runs.fromJson(json['text'] ?? {}),
      navigationEndpoint: json['navigationEndpoint'] != null
          ? NavigationEndpoint.fromJson(json['navigationEndpoint'])
          : null,
      command: json['command'] != null
          ? NavigationEndpoint.fromJson(json['command'])
          : null,
      icon: json['icon'] != null ? Icon.fromJson(json['icon']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text.toJson(),
        if (navigationEndpoint != null)
          'navigationEndpoint': navigationEndpoint!.toJson(),
        if (command != null) 'command': command!.toJson(),
        if (icon != null) 'icon': icon!.toJson(),
      };
}

class Continuation {
  final NextContinuationData? nextContinuationData;
  final NextContinuationData? nextRadioContinuationData;

  Continuation({
    this.nextContinuationData,
    NextContinuationData? nextRadioContinuationData,
  }) : nextRadioContinuationData =
            nextRadioContinuationData ?? nextContinuationData;

  factory Continuation.fromJson(Map<String, dynamic> json) {
    // Kotlin JsonNames("nextContinuationData", "nextRadioContinuationData")
    final data =
        json['nextContinuationData'] ?? json['nextRadioContinuationData'];
    return Continuation(
      nextContinuationData:
          data != null ? NextContinuationData.fromJson(data) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (nextContinuationData != null)
          'nextContinuationData': nextContinuationData!.toJson(),
      };
}

class NextContinuationData {
  final String continuation;

  NextContinuationData({required this.continuation});

  factory NextContinuationData.fromJson(Map<String, dynamic> json) {
    return NextContinuationData(
      continuation: json['continuation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'continuation': continuation,
      };
}

class ContinuationItemRenderer {
  final ContinuationEndpoint?
      continuationEndpoint; // Actually ContinuationEndpoint in my previous definition but logic uses Button too
  final ButtonRenderer? button;

  ContinuationItemRenderer({this.continuationEndpoint, this.button});

  factory ContinuationItemRenderer.fromJson(Map<String, dynamic> json) {
    return ContinuationItemRenderer(
      // Wait, ContinuationItemRenderer usually has 'continuationEndpoint' which is a NavigationEndpoint or similar structure?
      // In my step 189 I defined `ContinuationEndpoint` class inside `music_shelf_renderers.dart` with `continuationCommand`.
      // Let's reuse that.
      continuationEndpoint: json['continuationEndpoint'] != null
          ? ContinuationEndpoint.fromJson(json['continuationEndpoint'])
          : null,
      button: json['button'] != null
          ? ButtonRenderer.fromJson(json['button'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (continuationEndpoint != null)
          'continuationEndpoint': continuationEndpoint!.toJson(),
        if (button != null) 'button': button!.toJson(),
      };
}

class ContinuationEndpoint {
  final ContinuationCommand? continuationCommand;

  ContinuationEndpoint({this.continuationCommand});

  factory ContinuationEndpoint.fromJson(Map<String, dynamic> json) {
    return ContinuationEndpoint(
      continuationCommand: json['continuationCommand'] != null
          ? ContinuationCommand.fromJson(json['continuationCommand'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (continuationCommand != null)
          'continuationCommand': continuationCommand!.toJson(),
      };
}

class ContinuationCommand {
  final String token;
  final String request;

  ContinuationCommand({required this.token, required this.request});

  factory ContinuationCommand.fromJson(Map<String, dynamic> json) {
    return ContinuationCommand(
      token: json['token'] ?? '',
      request: json['request'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'request': request,
      };
}

// --- Music Responsive List Item ---
class MusicResponsiveListItemRenderer {
  final List<Badges>? badges;
  final List<FlexColumn>? fixedColumns;
  final List<FlexColumn> flexColumns;
  final ThumbnailRenderer? thumbnail;
  final Menu? menu;
  final PlaylistItemData? playlistItemData;
  final Overlay? overlay;
  final NavigationEndpoint? navigationEndpoint;
  final String? musicVideoType; // Add this field

  MusicResponsiveListItemRenderer({
    this.badges,
    this.fixedColumns,
    required this.flexColumns,
    this.thumbnail,
    this.menu,
    this.playlistItemData,
    this.overlay,
    this.navigationEndpoint,
    this.musicVideoType,
  });

  factory MusicResponsiveListItemRenderer.fromJson(Map<String, dynamic> json) {
    return MusicResponsiveListItemRenderer(
      badges: json['badges'] != null
          ? (json['badges'] as List).map((e) => Badges.fromJson(e)).toList()
          : null,
      fixedColumns: json['fixedColumns'] != null
          ? (json['fixedColumns'] as List)
              .map((e) => FlexColumn.fromJson(e))
              .toList()
          : null,
      flexColumns: (json['flexColumns'] as List? ?? [])
          .map((e) => FlexColumn.fromJson(e))
          .toList(),
      thumbnail: json['thumbnail'] != null
          ? ThumbnailRenderer.fromJson(json['thumbnail'])
          : null,
      menu: json['menu'] != null ? Menu.fromJson(json['menu']) : null,
      playlistItemData: json['playlistItemData'] != null
          ? PlaylistItemData.fromJson(json['playlistItemData'])
          : null,
      overlay:
          json['overlay'] != null ? Overlay.fromJson(json['overlay']) : null,
      navigationEndpoint: json['navigationEndpoint'] != null
          ? NavigationEndpoint.fromJson(json['navigationEndpoint'])
          : null,
      musicVideoType: json['musicVideoType'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (badges != null) 'badges': badges!.map((e) => e.toJson()).toList(),
        if (fixedColumns != null)
          'fixedColumns': fixedColumns!.map((e) => e.toJson()).toList(),
        'flexColumns': flexColumns.map((e) => e.toJson()).toList(),
        if (thumbnail != null) 'thumbnail': thumbnail!.toJson(),
        if (menu != null) 'menu': menu!.toJson(),
        if (playlistItemData != null)
          'playlistItemData': playlistItemData!.toJson(),
        if (overlay != null) 'overlay': overlay!.toJson(),
        if (navigationEndpoint != null)
          'navigationEndpoint': navigationEndpoint!.toJson(),
        if (musicVideoType != null) 'musicVideoType': musicVideoType,
      };

  // Helper getter for isSong (implied from NavigationEndpoint in Kotlin code,
  // but here check endpoint or rely on caller logic)
  bool get isSong => navigationEndpoint?.anyWatchEndpoint != null;
}

class FlexColumn {
  final MusicResponsiveListItemFlexColumnRenderer
      musicResponsiveListItemFlexColumnRenderer;

  FlexColumn({required this.musicResponsiveListItemFlexColumnRenderer});

  factory FlexColumn.fromJson(Map<String, dynamic> json) {
    return FlexColumn(
      musicResponsiveListItemFlexColumnRenderer:
          MusicResponsiveListItemFlexColumnRenderer.fromJson(
              json['musicResponsiveListItemFlexColumnRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'musicResponsiveListItemFlexColumnRenderer':
            musicResponsiveListItemFlexColumnRenderer.toJson(),
      };
}

class MusicResponsiveListItemFlexColumnRenderer {
  final Runs? text;

  MusicResponsiveListItemFlexColumnRenderer({this.text});

  factory MusicResponsiveListItemFlexColumnRenderer.fromJson(
      Map<String, dynamic> json) {
    return MusicResponsiveListItemFlexColumnRenderer(
      text: json['text'] != null ? Runs.fromJson(json['text']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (text != null) 'text': text!.toJson(),
      };
}

class PlaylistItemData {
  final String? playlistSetVideoId;
  final String videoId;

  PlaylistItemData({
    this.playlistSetVideoId,
    required this.videoId,
  });

  factory PlaylistItemData.fromJson(Map<String, dynamic> json) {
    return PlaylistItemData(
      playlistSetVideoId: json['playlistSetVideoId'],
      videoId: json['videoId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        if (playlistSetVideoId != null)
          'playlistSetVideoId': playlistSetVideoId,
        'videoId': videoId,
      };
}

class Overlay {
  final MusicItemThumbnailOverlayRenderer musicItemThumbnailOverlayRenderer;

  Overlay({required this.musicItemThumbnailOverlayRenderer});

  factory Overlay.fromJson(Map<String, dynamic> json) {
    return Overlay(
      musicItemThumbnailOverlayRenderer:
          MusicItemThumbnailOverlayRenderer.fromJson(
              json['musicItemThumbnailOverlayRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'musicItemThumbnailOverlayRenderer':
            musicItemThumbnailOverlayRenderer.toJson(),
      };
}

class MusicItemThumbnailOverlayRenderer {
  final OverlayContent content;

  MusicItemThumbnailOverlayRenderer({required this.content});

  factory MusicItemThumbnailOverlayRenderer.fromJson(
      Map<String, dynamic> json) {
    return MusicItemThumbnailOverlayRenderer(
      content: OverlayContent.fromJson(json['content'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content.toJson(),
      };
}

class OverlayContent {
  final MusicPlayButtonRenderer musicPlayButtonRenderer;

  OverlayContent({required this.musicPlayButtonRenderer});

  factory OverlayContent.fromJson(Map<String, dynamic> json) {
    return OverlayContent(
      musicPlayButtonRenderer: MusicPlayButtonRenderer.fromJson(
          json['musicPlayButtonRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'musicPlayButtonRenderer': musicPlayButtonRenderer.toJson(),
      };
}

class MusicPlayButtonRenderer {
  final NavigationEndpoint? playNavigationEndpoint;

  MusicPlayButtonRenderer({this.playNavigationEndpoint});

  factory MusicPlayButtonRenderer.fromJson(Map<String, dynamic> json) {
    return MusicPlayButtonRenderer(
      playNavigationEndpoint: json['playNavigationEndpoint'] != null
          ? NavigationEndpoint.fromJson(json['playNavigationEndpoint'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (playNavigationEndpoint != null)
          'playNavigationEndpoint': playNavigationEndpoint!.toJson(),
      };
}

// --- Music Two Row Item ---
class MusicTwoRowItemRenderer {
  final Runs title;
  final Runs? subtitle;
  final List<Badges>? subtitleBadges;
  final Menu? menu;
  final ThumbnailRenderer thumbnailRenderer;
  final NavigationEndpoint navigationEndpoint;
  final Overlay? thumbnailOverlay;
  final String? musicVideoType;

  MusicTwoRowItemRenderer({
    required this.title,
    this.subtitle,
    this.subtitleBadges,
    this.menu,
    required this.thumbnailRenderer,
    required this.navigationEndpoint,
    this.thumbnailOverlay,
    this.musicVideoType,
  });

  factory MusicTwoRowItemRenderer.fromJson(Map<String, dynamic> json) {
    return MusicTwoRowItemRenderer(
      title: Runs.fromJson(json['title'] ?? {}),
      subtitle:
          json['subtitle'] != null ? Runs.fromJson(json['subtitle']) : null,
      subtitleBadges: json['subtitleBadges'] != null
          ? (json['subtitleBadges'] as List)
              .map((e) => Badges.fromJson(e))
              .toList()
          : null,
      menu: json['menu'] != null ? Menu.fromJson(json['menu']) : null,
      thumbnailRenderer:
          ThumbnailRenderer.fromJson(json['thumbnailRenderer'] ?? {}),
      navigationEndpoint:
          NavigationEndpoint.fromJson(json['navigationEndpoint'] ?? {}),
      thumbnailOverlay: json['thumbnailOverlay'] != null
          ? Overlay.fromJson(json['thumbnailOverlay'])
          : null,
      musicVideoType: json['musicVideoType'],
    );
  }

  // Helpers
  bool get isSong => navigationEndpoint.anyWatchEndpoint != null;
  bool get isPlaylist =>
      navigationEndpoint.browseEndpoint?.isPlaylistEndpoint ?? false;
  bool get isAlbum =>
      navigationEndpoint.browseEndpoint?.isAlbumEndpoint ?? false;
  bool get isArtist =>
      navigationEndpoint.browseEndpoint?.isArtistEndpoint ?? false;

  Map<String, dynamic> toJson() => {
        'title': title.toJson(),
        if (subtitle != null) 'subtitle': subtitle!.toJson(),
        if (subtitleBadges != null)
          'subtitleBadges': subtitleBadges!.map((e) => e.toJson()).toList(),
        if (menu != null) 'menu': menu!.toJson(),
        'thumbnailRenderer': thumbnailRenderer.toJson(),
        'navigationEndpoint': navigationEndpoint.toJson(),
        if (thumbnailOverlay != null)
          'thumbnailOverlay': thumbnailOverlay!.toJson(),
        if (musicVideoType != null) 'musicVideoType': musicVideoType,
      };
}

// --- Music Shelf ---
class MusicShelfRenderer {
  final Runs? title;
  final List<MusicShelfContent>? contents;
  final List<Continuation>? continuations;
  final NavigationEndpoint? bottomEndpoint;
  final Button? moreContentButton;

  MusicShelfRenderer({
    this.title,
    this.contents,
    this.continuations,
    this.bottomEndpoint,
    this.moreContentButton,
  });

  factory MusicShelfRenderer.fromJson(Map<String, dynamic> json) {
    return MusicShelfRenderer(
      title: json['title'] != null ? Runs.fromJson(json['title']) : null,
      contents: json['contents'] != null
          ? (json['contents'] as List)
              .map((e) => MusicShelfContent.fromJson(e))
              .toList()
          : null,
      continuations: json['continuations'] != null
          ? (json['continuations'] as List)
              .map((e) => Continuation.fromJson(e))
              .toList()
          : null,
      bottomEndpoint: json['bottomEndpoint'] != null
          ? NavigationEndpoint.fromJson(json['bottomEndpoint'])
          : null,
      moreContentButton: json['moreContentButton'] != null
          ? Button.fromJson(json['moreContentButton'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title!.toJson(),
        if (contents != null)
          'contents': contents!.map((e) => e.toJson()).toList(),
        if (continuations != null)
          'continuations': continuations!.map((e) => e.toJson()).toList(),
        if (bottomEndpoint != null) 'bottomEndpoint': bottomEndpoint!.toJson(),
        if (moreContentButton != null)
          'moreContentButton': moreContentButton!.toJson(),
      };
}

class MusicShelfContent {
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;
  final ContinuationItemRenderer? continuationItemRenderer;

  MusicShelfContent({
    this.musicResponsiveListItemRenderer,
    this.continuationItemRenderer,
  });

  factory MusicShelfContent.fromJson(Map<String, dynamic> json) {
    return MusicShelfContent(
      musicResponsiveListItemRenderer:
          json['musicResponsiveListItemRenderer'] != null
              ? MusicResponsiveListItemRenderer.fromJson(
                  json['musicResponsiveListItemRenderer'])
              : null,
      continuationItemRenderer: json['continuationItemRenderer'] != null
          ? ContinuationItemRenderer.fromJson(json['continuationItemRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (musicResponsiveListItemRenderer != null)
          'musicResponsiveListItemRenderer':
              musicResponsiveListItemRenderer!.toJson(),
        if (continuationItemRenderer != null)
          'continuationItemRenderer': continuationItemRenderer!.toJson(),
      };
}

// --- Music Carousel Shelf ---
class MusicCarouselShelfRenderer {
  final MusicCarouselShelfHeader? header;
  final List<MusicCarouselShelfContent> contents;
  final String itemSize;
  final int? numItemsPerColumn;

  MusicCarouselShelfRenderer({
    this.header,
    required this.contents,
    required this.itemSize,
    this.numItemsPerColumn,
  });

  factory MusicCarouselShelfRenderer.fromJson(Map<String, dynamic> json) {
    final numItemsRaw = json['numItemsPerColumn'];
    final int? numItemsPerColumn = numItemsRaw is int
        ? numItemsRaw
        : (numItemsRaw is String ? int.tryParse(numItemsRaw) : null);
    return MusicCarouselShelfRenderer(
      header: json['header'] != null
          ? MusicCarouselShelfHeader.fromJson(json['header'])
          : null,
      contents: (json['contents'] as List? ?? [])
          .map((e) => MusicCarouselShelfContent.fromJson(e))
          .toList(),
      itemSize: json['itemSize'] ?? '',
      numItemsPerColumn: numItemsPerColumn,
    );
  }

  Map<String, dynamic> toJson() => {
        if (header != null) 'header': header!.toJson(),
        'contents': contents.map((e) => e.toJson()).toList(),
        'itemSize': itemSize,
        if (numItemsPerColumn != null) 'numItemsPerColumn': numItemsPerColumn,
      };
}

class MusicCarouselShelfHeader {
  final MusicCarouselShelfBasicHeaderRenderer
      musicCarouselShelfBasicHeaderRenderer;

  MusicCarouselShelfHeader({
    required this.musicCarouselShelfBasicHeaderRenderer,
  });

  factory MusicCarouselShelfHeader.fromJson(Map<String, dynamic> json) {
    return MusicCarouselShelfHeader(
      musicCarouselShelfBasicHeaderRenderer:
          MusicCarouselShelfBasicHeaderRenderer.fromJson(
              json['musicCarouselShelfBasicHeaderRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'musicCarouselShelfBasicHeaderRenderer':
            musicCarouselShelfBasicHeaderRenderer.toJson(),
      };
}

class MusicCarouselShelfBasicHeaderRenderer {
  final Runs? strapline;
  final Runs title;
  final ThumbnailRenderer? thumbnail;
  final Button? moreContentButton;

  MusicCarouselShelfBasicHeaderRenderer({
    this.strapline,
    required this.title,
    this.thumbnail,
    this.moreContentButton,
  });

  factory MusicCarouselShelfBasicHeaderRenderer.fromJson(
      Map<String, dynamic> json) {
    return MusicCarouselShelfBasicHeaderRenderer(
      strapline:
          json['strapline'] != null ? Runs.fromJson(json['strapline']) : null,
      title: Runs.fromJson(json['title'] ?? {}),
      thumbnail: json['thumbnail'] != null
          ? ThumbnailRenderer.fromJson(json['thumbnail'])
          : null,
      moreContentButton: json['moreContentButton'] != null
          ? Button.fromJson(json['moreContentButton'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (strapline != null) 'strapline': strapline!.toJson(),
        'title': title.toJson(),
        if (thumbnail != null) 'thumbnail': thumbnail!.toJson(),
        if (moreContentButton != null)
          'moreContentButton': moreContentButton!.toJson(),
      };
}

class MusicCarouselShelfContent {
  final MusicTwoRowItemRenderer? musicTwoRowItemRenderer;
  final MusicResponsiveListItemRenderer? musicResponsiveListItemRenderer;
  final MusicNavigationButtonRenderer? musicNavigationButtonRenderer;

  MusicCarouselShelfContent({
    this.musicTwoRowItemRenderer,
    this.musicResponsiveListItemRenderer,
    this.musicNavigationButtonRenderer,
  });

  factory MusicCarouselShelfContent.fromJson(Map<String, dynamic> json) {
    return MusicCarouselShelfContent(
      musicTwoRowItemRenderer: json['musicTwoRowItemRenderer'] != null
          ? MusicTwoRowItemRenderer.fromJson(json['musicTwoRowItemRenderer'])
          : null,
      musicResponsiveListItemRenderer:
          json['musicResponsiveListItemRenderer'] != null
              ? MusicResponsiveListItemRenderer.fromJson(
                  json['musicResponsiveListItemRenderer'])
              : null,
      musicNavigationButtonRenderer:
          json['musicNavigationButtonRenderer'] != null
              ? MusicNavigationButtonRenderer.fromJson(
                  json['musicNavigationButtonRenderer'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (musicTwoRowItemRenderer != null)
          'musicTwoRowItemRenderer': musicTwoRowItemRenderer!.toJson(),
        if (musicResponsiveListItemRenderer != null)
          'musicResponsiveListItemRenderer':
              musicResponsiveListItemRenderer!.toJson(),
        if (musicNavigationButtonRenderer != null)
          'musicNavigationButtonRenderer':
              musicNavigationButtonRenderer!.toJson(),
      };
}

class MusicNavigationButtonRenderer {
  final ButtonRenderer? buttonRenderer;

  MusicNavigationButtonRenderer({this.buttonRenderer});

  factory MusicNavigationButtonRenderer.fromJson(Map<String, dynamic> json) {
    return MusicNavigationButtonRenderer(
      buttonRenderer: json['buttonRenderer'] != null
          ? ButtonRenderer.fromJson(json['buttonRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (buttonRenderer != null) 'buttonRenderer': buttonRenderer!.toJson(),
      };
}

// --- Tabs & SectionList ---
class Tabs {
  final List<Tab> tabs;

  Tabs({required this.tabs});

  factory Tabs.fromJson(Map<String, dynamic> json) {
    return Tabs(
      tabs: (json['tabs'] as List? ?? []).map((e) => Tab.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'tabs': tabs.map((e) => e.toJson()).toList(),
      };
}

class Tab {
  final TabRenderer tabRenderer;

  Tab({required this.tabRenderer});

  factory Tab.fromJson(Map<String, dynamic> json) {
    return Tab(
      tabRenderer: TabRenderer.fromJson(json['tabRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'tabRenderer': tabRenderer.toJson(),
      };
}

class TabRenderer {
  final String? title;
  final TabContent? content;
  final NavigationEndpoint? endpoint;

  TabRenderer({
    this.title,
    this.content,
    this.endpoint,
  });

  factory TabRenderer.fromJson(Map<String, dynamic> json) {
    return TabRenderer(
      title: json['title'],
      content:
          json['content'] != null ? TabContent.fromJson(json['content']) : null,
      endpoint: json['endpoint'] != null
          ? NavigationEndpoint.fromJson(json['endpoint'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (content != null) 'content': content!.toJson(),
        if (endpoint != null) 'endpoint': endpoint!.toJson(),
      };
}

class TabContent {
  final SectionListRenderer? sectionListRenderer;

  TabContent({this.sectionListRenderer});

  factory TabContent.fromJson(Map<String, dynamic> json) {
    return TabContent(
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

class SectionListRenderer {
  final SectionListHeader? header;
  final List<SectionListContent>? contents;
  final List<Continuation>? continuations;

  SectionListRenderer({
    this.header,
    this.contents,
    this.continuations,
  });

  factory SectionListRenderer.fromJson(Map<String, dynamic> json) {
    return SectionListRenderer(
      header: json['header'] != null
          ? SectionListHeader.fromJson(json['header'])
          : null,
      contents: json['contents'] != null
          ? (json['contents'] as List)
              .map((e) => SectionListContent.fromJson(e))
              .toList()
          : null,
      continuations: json['continuations'] != null
          ? (json['continuations'] as List)
              .map((e) => Continuation.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (header != null) 'header': header!.toJson(),
        if (contents != null)
          'contents': contents!.map((e) => e.toJson()).toList(),
        if (continuations != null)
          'continuations': continuations!.map((e) => e.toJson()).toList(),
      };
}

class SectionListHeader {
  final ChipCloudRenderer? chipCloudRenderer;

  SectionListHeader({this.chipCloudRenderer});

  factory SectionListHeader.fromJson(Map<String, dynamic> json) {
    return SectionListHeader(
      chipCloudRenderer: json['chipCloudRenderer'] != null
          ? ChipCloudRenderer.fromJson(json['chipCloudRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (chipCloudRenderer != null)
          'chipCloudRenderer': chipCloudRenderer!.toJson(),
      };
}

class ChipCloudRenderer {
  final List<Chip> chips;

  ChipCloudRenderer({required this.chips});

  factory ChipCloudRenderer.fromJson(Map<String, dynamic> json) {
    return ChipCloudRenderer(
      chips:
          (json['chips'] as List? ?? []).map((e) => Chip.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'chips': chips.map((e) => e.toJson()).toList(),
      };
}

class Chip {
  final ChipCloudChipRenderer chipCloudChipRenderer;

  Chip({required this.chipCloudChipRenderer});

  factory Chip.fromJson(Map<String, dynamic> json) {
    return Chip(
      chipCloudChipRenderer:
          ChipCloudChipRenderer.fromJson(json['chipCloudChipRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'chipCloudChipRenderer': chipCloudChipRenderer.toJson(),
      };
}

class ChipCloudChipRenderer {
  final bool isSelected;
  final NavigationEndpoint navigationEndpoint;
  final NavigationEndpoint? onDeselectedCommand;
  final Runs? text;
  final String? uniqueId;

  ChipCloudChipRenderer({
    this.isSelected = false,
    required this.navigationEndpoint,
    this.onDeselectedCommand,
    this.text,
    this.uniqueId,
  });

  factory ChipCloudChipRenderer.fromJson(Map<String, dynamic> json) {
    return ChipCloudChipRenderer(
      isSelected: json['isSelected'] ?? false,
      navigationEndpoint:
          NavigationEndpoint.fromJson(json['navigationEndpoint'] ?? {}),
      onDeselectedCommand: json['onDeselectedCommand'] != null
          ? NavigationEndpoint.fromJson(json['onDeselectedCommand'])
          : null,
      text: json['text'] != null ? Runs.fromJson(json['text']) : null,
      uniqueId: json['uniqueId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'isSelected': isSelected,
        'navigationEndpoint': navigationEndpoint.toJson(),
        if (onDeselectedCommand != null)
          'onDeselectedCommand': onDeselectedCommand!.toJson(),
        if (text != null) 'text': text!.toJson(),
        if (uniqueId != null) 'uniqueId': uniqueId,
      };
}

class SectionListContent {
  final MusicCarouselShelfRenderer? musicCarouselShelfRenderer;
  final MusicShelfRenderer? musicShelfRenderer;

  SectionListContent({
    this.musicCarouselShelfRenderer,
    this.musicShelfRenderer,
  });

  factory SectionListContent.fromJson(Map<String, dynamic> json) {
    return SectionListContent(
      musicCarouselShelfRenderer: json['musicCarouselShelfRenderer'] != null
          ? MusicCarouselShelfRenderer.fromJson(
              json['musicCarouselShelfRenderer'])
          : null,
      musicShelfRenderer: json['musicShelfRenderer'] != null
          ? MusicShelfRenderer.fromJson(json['musicShelfRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (musicCarouselShelfRenderer != null)
          'musicCarouselShelfRenderer': musicCarouselShelfRenderer!.toJson(),
        if (musicShelfRenderer != null)
          'musicShelfRenderer': musicShelfRenderer!.toJson(),
      };
}
