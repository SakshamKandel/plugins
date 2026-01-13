import '../context.dart';

class GetQueueBody {
  final Context context;
  final List<String>? videoIds;
  final String? playlistId;

  const GetQueueBody({
    required this.context,
    this.videoIds,
    this.playlistId,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        if (videoIds != null) 'videoIds': videoIds,
        if (playlistId != null) 'playlistId': playlistId,
      };
}
