import '../context.dart';

class SearchBody {
  final Context context;
  final String? query;
  final String? params;

  const SearchBody({
    required this.context,
    this.query,
    this.params,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        if (query != null) 'query': query,
        if (params != null) 'params': params,
      };
}
