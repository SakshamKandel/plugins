import '../context.dart';

class GetTranscriptBody {
  final Context context;
  final String params;

  const GetTranscriptBody({
    required this.context,
    required this.params,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'params': params,
      };
}
