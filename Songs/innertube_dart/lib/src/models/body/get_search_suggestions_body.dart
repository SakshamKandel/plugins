import '../context.dart';

class GetSearchSuggestionsBody {
  final Context context;
  final String input;

  const GetSearchSuggestionsBody({
    required this.context,
    required this.input,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'input': input,
      };
}
