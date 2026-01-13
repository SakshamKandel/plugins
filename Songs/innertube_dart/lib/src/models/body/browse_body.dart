import '../context.dart';

class BrowseBody {
  final Context context;
  final String? browseId;
  final String? params;
  final String? continuation;

  const BrowseBody({
    required this.context,
    this.browseId,
    this.params,
    this.continuation,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        if (browseId != null) 'browseId': browseId,
        if (params != null) 'params': params,
        if (continuation != null) 'continuation': continuation,
      };
}
