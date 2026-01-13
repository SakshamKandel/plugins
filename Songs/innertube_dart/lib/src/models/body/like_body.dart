import '../context.dart';

class LikeBody {
  final Context context;
  final LikeTarget target;

  const LikeBody({
    required this.context,
    required this.target,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'target': target.toJson(),
      };
}

abstract class LikeTarget {
  Map<String, dynamic> toJson();
}

class VideoTarget extends LikeTarget {
  final String videoId;

  VideoTarget(this.videoId);

  @override
  Map<String, dynamic> toJson() => {
        'videoId': videoId,
      };
}

class PlaylistTarget extends LikeTarget {
  final String playlistId;

  PlaylistTarget(this.playlistId);

  @override
  Map<String, dynamic> toJson() => {
        'playlistId': playlistId,
      };
}
