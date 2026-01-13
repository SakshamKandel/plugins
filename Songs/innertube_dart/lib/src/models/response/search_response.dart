import '../renderers/music_shelf_renderers.dart';

class SearchResponse {
  final SearchResponseContents? contents;
  final ContinuationContents? continuationContents;

  SearchResponse({
    this.contents,
    this.continuationContents,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      contents: json['contents'] != null
          ? SearchResponseContents.fromJson(json['contents'])
          : null,
      continuationContents: json['continuationContents'] != null
          ? ContinuationContents.fromJson(json['continuationContents'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (contents != null) 'contents': contents!.toJson(),
        if (continuationContents != null)
          'continuationContents': continuationContents!.toJson(),
      };
}

class SearchResponseContents {
  final Tabs? tabbedSearchResultsRenderer;

  SearchResponseContents({this.tabbedSearchResultsRenderer});

  factory SearchResponseContents.fromJson(Map<String, dynamic> json) {
    return SearchResponseContents(
      tabbedSearchResultsRenderer: json['tabbedSearchResultsRenderer'] != null
          ? Tabs.fromJson(json['tabbedSearchResultsRenderer'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (tabbedSearchResultsRenderer != null)
          'tabbedSearchResultsRenderer': tabbedSearchResultsRenderer!.toJson(),
      };
}

class ContinuationContents {
  final MusicShelfContinuation musicShelfContinuation;

  ContinuationContents({required this.musicShelfContinuation});

  factory ContinuationContents.fromJson(Map<String, dynamic> json) {
    return ContinuationContents(
      musicShelfContinuation:
          MusicShelfContinuation.fromJson(json['musicShelfContinuation'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'musicShelfContinuation': musicShelfContinuation.toJson(),
      };
}

class MusicShelfContinuation {
  final List<MusicShelfContent> contents;
  final List<Continuation>? continuations;

  MusicShelfContinuation({
    required this.contents,
    this.continuations,
  });

  factory MusicShelfContinuation.fromJson(Map<String, dynamic> json) {
    return MusicShelfContinuation(
      contents: (json['contents'] as List? ?? [])
          .map((e) => MusicShelfContent.fromJson(e))
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
