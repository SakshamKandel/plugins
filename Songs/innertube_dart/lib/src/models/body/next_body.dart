import '../context.dart';

class NextBody {
  final Context context;
  final String? videoId;
  final String? playlistId;
  final String? playlistSetVideoId;
  final int? index;
  final String? params;
  final String? continuation;

  const NextBody({
    required this.context,
    this.videoId,
    this.playlistId,
    this.playlistSetVideoId,
    this.index,
    this.params,
    this.continuation,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        if (videoId != null) 'videoId': videoId,
        if (playlistId != null) 'playlistId': playlistId,
        if (playlistSetVideoId != null)
          'playlistSetVideoId': playlistSetVideoId,
        if (index != null) 'index': index,
        if (params != null) 'params': params,
        if (continuation != null) 'continuation': continuation,
      };
}
