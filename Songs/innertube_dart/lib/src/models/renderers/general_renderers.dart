import '../navigation_endpoint.dart';
import '../runs.dart';

// --- Icon ---
class Icon {
  final String iconType;

  Icon({required this.iconType});

  factory Icon.fromJson(Map<String, dynamic> json) {
    return Icon(iconType: json['iconType'] ?? '');
  }

  Map<String, dynamic> toJson() => {'iconType': iconType};
}

// --- Menu ---
class Menu {
  final MenuRenderer menuRenderer;

  Menu({required this.menuRenderer});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      menuRenderer: MenuRenderer.fromJson(json['menuRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {'menuRenderer': menuRenderer.toJson()};
}

class MenuRenderer {
  final List<MenuItem>? items;
  final List<TopLevelButton>? topLevelButtons;

  MenuRenderer({this.items, this.topLevelButtons});

  factory MenuRenderer.fromJson(Map<String, dynamic> json) {
    return MenuRenderer(
      items: json['items'] != null
          ? (json['items'] as List).map((e) => MenuItem.fromJson(e)).toList()
          : null,
      topLevelButtons: json['topLevelButtons'] != null
          ? (json['topLevelButtons'] as List)
              .map((e) => TopLevelButton.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (items != null) 'items': items!.map((e) => e.toJson()).toList(),
        if (topLevelButtons != null)
          'topLevelButtons': topLevelButtons!.map((e) => e.toJson()).toList(),
      };
}

class MenuItem {
  final MenuNavigationItemRenderer? menuNavigationItemRenderer;
  final MenuServiceItemRenderer? menuServiceItemRenderer;
  final ToggleMenuServiceRenderer? toggleMenuServiceItemRenderer;

  MenuItem({
    this.menuNavigationItemRenderer,
    this.menuServiceItemRenderer,
    this.toggleMenuServiceItemRenderer,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      menuNavigationItemRenderer: json['menuNavigationItemRenderer'] != null
          ? MenuNavigationItemRenderer.fromJson(
              json['menuNavigationItemRenderer'])
          : null,
      menuServiceItemRenderer: json['menuServiceItemRenderer'] != null
          ? MenuServiceItemRenderer.fromJson(json['menuServiceItemRenderer'])
          : null,
      toggleMenuServiceItemRenderer:
          json['toggleMenuServiceItemRenderer'] != null
              ? ToggleMenuServiceRenderer.fromJson(
                  json['toggleMenuServiceItemRenderer'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (menuNavigationItemRenderer != null)
          'menuNavigationItemRenderer': menuNavigationItemRenderer!.toJson(),
        if (menuServiceItemRenderer != null)
          'menuServiceItemRenderer': menuServiceItemRenderer!.toJson(),
        if (toggleMenuServiceItemRenderer != null)
          'toggleMenuServiceItemRenderer':
              toggleMenuServiceItemRenderer!.toJson(),
      };
}

class MenuNavigationItemRenderer {
  final Runs text;
  final Icon icon;
  final NavigationEndpoint navigationEndpoint;

  MenuNavigationItemRenderer({
    required this.text,
    required this.icon,
    required this.navigationEndpoint,
  });

  factory MenuNavigationItemRenderer.fromJson(Map<String, dynamic> json) {
    return MenuNavigationItemRenderer(
      text: Runs.fromJson(json['text'] ?? {}),
      icon: Icon.fromJson(json['icon'] ?? {}),
      navigationEndpoint:
          NavigationEndpoint.fromJson(json['navigationEndpoint'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text.toJson(),
        'icon': icon.toJson(),
        'navigationEndpoint': navigationEndpoint.toJson(),
      };
}

class MenuServiceItemRenderer {
  final Runs text;
  final Icon icon;
  final NavigationEndpoint serviceEndpoint;

  MenuServiceItemRenderer({
    required this.text,
    required this.icon,
    required this.serviceEndpoint,
  });

  factory MenuServiceItemRenderer.fromJson(Map<String, dynamic> json) {
    return MenuServiceItemRenderer(
      text: Runs.fromJson(json['text'] ?? {}),
      icon: Icon.fromJson(json['icon'] ?? {}),
      serviceEndpoint:
          NavigationEndpoint.fromJson(json['serviceEndpoint'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text.toJson(),
        'icon': icon.toJson(),
        'serviceEndpoint': serviceEndpoint.toJson(),
      };
}

class ToggleMenuServiceRenderer {
  final Icon defaultIcon;
  final Map<String, dynamic>? defaultServiceEndpointRaw;
  final Map<String, dynamic>? toggledServiceEndpointRaw;

  ToggleMenuServiceRenderer({
    required this.defaultIcon,
    this.defaultServiceEndpointRaw,
    this.toggledServiceEndpointRaw,
  });

  factory ToggleMenuServiceRenderer.fromJson(Map<String, dynamic> json) {
    return ToggleMenuServiceRenderer(
      defaultIcon: Icon.fromJson(json['defaultIcon'] ?? {}),
      defaultServiceEndpointRaw: json['defaultServiceEndpoint'],
      toggledServiceEndpointRaw: json['toggledServiceEndpoint'],
    );
  }

  Map<String, dynamic> toJson() => {
        'defaultIcon': defaultIcon.toJson(),
        if (defaultServiceEndpointRaw != null)
          'defaultServiceEndpoint': defaultServiceEndpointRaw,
        if (toggledServiceEndpointRaw != null)
          'toggledServiceEndpoint': toggledServiceEndpointRaw,
      };
}

class TopLevelButton {
  final ButtonRenderer? buttonRenderer;

  TopLevelButton({this.buttonRenderer});

  factory TopLevelButton.fromJson(Map<String, dynamic> json) {
    return TopLevelButton(
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
  final Icon icon;
  final NavigationEndpoint navigationEndpoint;

  ButtonRenderer({
    required this.icon,
    required this.navigationEndpoint,
  });

  factory ButtonRenderer.fromJson(Map<String, dynamic> json) {
    return ButtonRenderer(
      icon: Icon.fromJson(json['icon'] ?? {}),
      navigationEndpoint:
          NavigationEndpoint.fromJson(json['navigationEndpoint'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'icon': icon.toJson(),
        'navigationEndpoint': navigationEndpoint.toJson(),
      };
}

// --- Thumbnails ---
class Thumbnails {
  final List<Thumbnail> thumbnails;

  Thumbnails({required this.thumbnails});

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    return Thumbnails(
      thumbnails: (json['thumbnails'] as List? ?? [])
          .map((e) => Thumbnail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'thumbnails': thumbnails.map((e) => e.toJson()).toList(),
      };
}

class Thumbnail {
  final String url;
  final int width;
  final int height;

  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'url': url,
        'width': width,
        'height': height,
      };
}

class ThumbnailRenderer {
  final MusicThumbnailRenderer? musicThumbnailRenderer;
  final MusicAnimatedThumbnailRenderer? musicAnimatedThumbnailRenderer;
  final MusicThumbnailRenderer? croppedSquareThumbnailRenderer;

  ThumbnailRenderer({
    this.musicThumbnailRenderer,
    this.musicAnimatedThumbnailRenderer,
    this.croppedSquareThumbnailRenderer,
  });

  factory ThumbnailRenderer.fromJson(Map<String, dynamic> json) {
    return ThumbnailRenderer(
      musicThumbnailRenderer: json['musicThumbnailRenderer'] != null
          ? MusicThumbnailRenderer.fromJson(json['musicThumbnailRenderer'])
          : null,
      musicAnimatedThumbnailRenderer:
          json['musicAnimatedThumbnailRenderer'] != null
              ? MusicAnimatedThumbnailRenderer.fromJson(
                  json['musicAnimatedThumbnailRenderer'])
              : null,
      croppedSquareThumbnailRenderer:
          json['croppedSquareThumbnailRenderer'] != null
              ? MusicThumbnailRenderer.fromJson(
                  json['croppedSquareThumbnailRenderer'])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (musicThumbnailRenderer != null)
          'musicThumbnailRenderer': musicThumbnailRenderer!.toJson(),
        if (musicAnimatedThumbnailRenderer != null)
          'musicAnimatedThumbnailRenderer':
              musicAnimatedThumbnailRenderer!.toJson(),
        if (croppedSquareThumbnailRenderer != null)
          'croppedSquareThumbnailRenderer':
              croppedSquareThumbnailRenderer!.toJson(),
      };

  String? getThumbnailUrl() =>
      musicThumbnailRenderer?.getThumbnailUrl() ??
      croppedSquareThumbnailRenderer?.getThumbnailUrl() ??
      musicAnimatedThumbnailRenderer?.backupRenderer.getThumbnailUrl();
}

class MusicThumbnailRenderer {
  final Thumbnails thumbnail;
  final String? thumbnailCrop;
  final String? thumbnailScale;

  MusicThumbnailRenderer({
    required this.thumbnail,
    this.thumbnailCrop,
    this.thumbnailScale,
  });

  factory MusicThumbnailRenderer.fromJson(Map<String, dynamic> json) {
    return MusicThumbnailRenderer(
      thumbnail: Thumbnails.fromJson(json['thumbnail'] ?? {'thumbnails': []}),
      thumbnailCrop: json['thumbnailCrop'],
      thumbnailScale: json['thumbnailScale'],
    );
  }

  String? getThumbnailUrl() =>
      thumbnail.thumbnails.isNotEmpty ? thumbnail.thumbnails.last.url : null;

  Map<String, dynamic> toJson() => {
        'thumbnail': thumbnail.toJson(),
        if (thumbnailCrop != null) 'thumbnailCrop': thumbnailCrop,
        if (thumbnailScale != null) 'thumbnailScale': thumbnailScale,
      };
}

class MusicAnimatedThumbnailRenderer {
  final Thumbnails animatedThumbnail;
  final MusicThumbnailRenderer backupRenderer;

  MusicAnimatedThumbnailRenderer({
    required this.animatedThumbnail,
    required this.backupRenderer,
  });

  factory MusicAnimatedThumbnailRenderer.fromJson(Map<String, dynamic> json) {
    return MusicAnimatedThumbnailRenderer(
      animatedThumbnail:
          Thumbnails.fromJson(json['animatedThumbnail'] ?? {'thumbnails': []}),
      backupRenderer:
          MusicThumbnailRenderer.fromJson(json['backupRenderer'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'animatedThumbnail': animatedThumbnail.toJson(),
        'backupRenderer': backupRenderer.toJson(),
      };
}

// --- Badges ---
class Badges {
  final MusicInlineBadgeRenderer? musicInlineBadgeRenderer;

  Badges({this.musicInlineBadgeRenderer});

  factory Badges.fromJson(Map<String, dynamic> json) {
    return Badges(
      musicInlineBadgeRenderer: json['musicInlineBadgeRenderer'] != null
          ? MusicInlineBadgeRenderer.fromJson(json['musicInlineBadgeRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (musicInlineBadgeRenderer != null)
          'musicInlineBadgeRenderer': musicInlineBadgeRenderer!.toJson(),
      };
}

class MusicInlineBadgeRenderer {
  final String accessibilityData;
  final Icon icon;

  MusicInlineBadgeRenderer({
    required this.accessibilityData,
    required this.icon,
  });

  factory MusicInlineBadgeRenderer.fromJson(Map<String, dynamic> json) {
    return MusicInlineBadgeRenderer(
      accessibilityData:
          json['accessibilityData']?['accessibilityData']?['label'] ?? '',
      icon: Icon.fromJson(json['icon'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'accessibilityData': accessibilityData,
        'icon': icon.toJson(),
      };
}
