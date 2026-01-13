import '../context.dart';

class FeedbackBody {
  final Context context;
  final List<String> feedbackTokens;
  final bool isFeedbackTokenUnencrypted;
  final bool shouldMerge;

  const FeedbackBody({
    required this.context,
    required this.feedbackTokens,
    this.isFeedbackTokenUnencrypted = false,
    this.shouldMerge = false,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'feedbackTokens': feedbackTokens,
        'isFeedbackTokenUnencrypted': isFeedbackTokenUnencrypted,
        'shouldMerge': shouldMerge,
      };
}
