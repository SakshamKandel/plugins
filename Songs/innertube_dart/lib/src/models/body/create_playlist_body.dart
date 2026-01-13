import '../context.dart';

class CreatePlaylistBody {
  final Context context;
  final String title;
  final String privacyStatus;
  final List<String>? videoIds;

  const CreatePlaylistBody({
    required this.context,
    required this.title,
    this.privacyStatus = PrivacyStatus.PRIVATE,
    this.videoIds,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'title': title,
        'privacyStatus': privacyStatus,
        if (videoIds != null) 'videoIds': videoIds,
      };
}

class PrivacyStatus {
  static const String PRIVATE = "PRIVATE";
  static const String PUBLIC = "PUBLIC";
  static const String UNLISTED = "UNLISTED";
}
