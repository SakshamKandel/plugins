import 'navigation_endpoint.dart';

class Runs {
  final List<Run>? runs;

  const Runs({this.runs});

  // Constructor to create Runs from a single String
  Runs.fromString(String text) : runs = [Run(text: text)];

  factory Runs.fromJson(Map<String, dynamic> json) {
    if (json['runs'] != null) {
      return Runs(
        runs: (json['runs'] as List).map((e) => Run.fromJson(e)).toList(),
      );
    }
    return Runs();
  }

  Map<String, dynamic> toJson() => {
        if (runs != null) 'runs': runs!.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() {
    return runs?.map((e) => e.text).join('') ?? '';
  }
}

class Run {
  final String text;
  final NavigationEndpoint? navigationEndpoint;

  const Run({
    required this.text,
    this.navigationEndpoint,
  });

  factory Run.fromJson(Map<String, dynamic> json) {
    return Run(
      text: json['text'] ?? '',
      navigationEndpoint: json['navigationEndpoint'] != null
          ? NavigationEndpoint.fromJson(json['navigationEndpoint'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        if (navigationEndpoint != null)
          'navigationEndpoint': navigationEndpoint!.toJson(),
      };
}

// Extension methods
extension RunsListExtension on List<Run> {
  List<List<Run>> splitBySeparator() {
    final result = <List<Run>>[];
    var currentChunk = <Run>[];

    for (var run in this) {
      if (run.text == " • ") {
        if (currentChunk.isNotEmpty) {
          result.add(List.from(currentChunk));
          currentChunk.clear();
        }
      } else {
        currentChunk.add(run);
      }
    }
    if (currentChunk.isNotEmpty) {
      result.add(currentChunk);
    }
    return result;
  }

  // Clean runs: filter out separators like " • "
  List<Run> clean() {
    return where((run) => run.text != " • ").toList();
  }

  List<T> oddElements<T>() {
    List<T> result = [];
    for (int i = 0; i < length; i++) {
      if (i % 2 == 0) {
        result.add(this[i] as T);
      }
    }
    return result;
  }
}
