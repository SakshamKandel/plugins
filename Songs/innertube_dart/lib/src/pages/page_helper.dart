import '../models/renderers/general_renderers.dart';
import '../models/renderers/music_shelf_renderers.dart';
import '../models/runs.dart';

class PageHelper {
  static String? extractFeedbackToken(
    ToggleMenuServiceRenderer? renderer,
    String prefix,
  ) {
    if (renderer?.defaultIcon.iconType.startsWith(prefix) == true) {
      return renderer?.defaultServiceEndpointRaw?['feedbackEndpoint']
          ?['feedbackToken'];
      // Note: We used raw map for defaultServiceEndpoint in ToggleMenuServiceRenderer
      // because of circular dependency. Adjust path if model changes.
    }
    return renderer?.toggledServiceEndpointRaw?['feedbackEndpoint']
        ?['feedbackToken'];
  }

  static List<Run> extractRuns(
    List<FlexColumn> flexColumns,
    String? typeFilter,
  ) {
    // Basic extraction, logic may need refinement based on filters
    // Kotlin code: renderer.flexColumns, "MUSIC_VIDEO" -> filters by page type or endpoint?

    // In Kotlin AlbumPage.kt: extractRuns(renderer.flexColumns, "MUSIC_VIDEO")
    // It implies we check the endpoint type of the run.

    // Simplified logic: Iterate all runs in all columns?
    // Usually columns have specific indices.
    // Let's just return all runs for now or try to match logic if simple.
    // Kotlin code doesn't show implementation of extractRuns, but it's likely searching for runs with specific endpoint types.

    // If we assume extractRuns just filters runs that lead to that type.

    final runs = <Run>[];
    for (var col in flexColumns) {
      final columnRuns =
          col.musicResponsiveListItemFlexColumnRenderer.text?.runs;
      if (columnRuns != null) {
        // If typeFilter is provided, we check navigationEndpoint
        if (typeFilter != null) {
          // Placeholder for endpoint filtering logic if needed later.
        }
        runs.addAll(columnRuns);
      }
    }
    return runs;
  }
}
