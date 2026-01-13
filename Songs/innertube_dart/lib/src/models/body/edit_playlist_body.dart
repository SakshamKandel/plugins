import '../context.dart';

class EditPlaylistBody {
  final Context context;
  final String playlistId;
  final List<EditPlaylistAction> actions;

  const EditPlaylistBody({
    required this.context,
    required this.playlistId,
    required this.actions,
  });

  Map<String, dynamic> toJson() => {
        'context': context.toJson(),
        'playlistId': playlistId,
        'actions': actions.map((e) => e.toJson()).toList(),
      };
}

abstract class EditPlaylistAction {
  Map<String, dynamic> toJson();
}

class AddVideoAction extends EditPlaylistAction {
  final String action;
  final String addedVideoId;

  AddVideoAction({
    this.action = "ACTION_ADD_VIDEO",
    required this.addedVideoId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'addedVideoId': addedVideoId,
      };
}

class AddPlaylistAction extends EditPlaylistAction {
  final String action;
  final String addedFullListId;

  AddPlaylistAction({
    this.action = "ACTION_ADD_PLAYLIST",
    required this.addedFullListId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'addedFullListId': addedFullListId,
      };
}

class MoveVideoAction extends EditPlaylistAction {
  final String action;
  final String setVideoId;
  final String? movedSetVideoIdSuccessor;

  MoveVideoAction({
    this.action = "ACTION_MOVE_VIDEO_BEFORE",
    required this.setVideoId,
    this.movedSetVideoIdSuccessor,
  });

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'setVideoId': setVideoId,
        if (movedSetVideoIdSuccessor != null)
          'movedSetVideoIdSuccessor': movedSetVideoIdSuccessor,
      };
}

class RemoveVideoAction extends EditPlaylistAction {
  final String action;
  final String setVideoId;
  final String removedVideoId;

  RemoveVideoAction({
    this.action = "ACTION_REMOVE_VIDEO",
    required this.setVideoId,
    required this.removedVideoId,
  });

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'setVideoId': setVideoId,
        'removedVideoId': removedVideoId,
      };
}

class RenamePlaylistAction extends EditPlaylistAction {
  final String action;
  final String playlistName;

  RenamePlaylistAction({
    this.action = "ACTION_SET_PLAYLIST_NAME",
    required this.playlistName,
  });

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'playlistName': playlistName,
      };
}

class SetCustomThumbnailAction extends EditPlaylistAction {
  final String action;
  final AddedCustomThumbnail addedCustomThumbnail;

  SetCustomThumbnailAction({
    this.action = "ACTION_SET_CUSTOM_THUMBNAIL",
    required this.addedCustomThumbnail,
  });

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'addedCustomThumbnail': addedCustomThumbnail.toJson(),
      };
}

class AddedCustomThumbnail {
  final ImageKey imageKey;
  final String playlistScottyEncryptedBlobId;

  AddedCustomThumbnail({
    ImageKey? imageKey,
    required this.playlistScottyEncryptedBlobId,
  }) : imageKey = imageKey ??
            ImageKey(
              name: "studio_square_thumbnail",
              type: "PLAYLIST_IMAGE_TYPE_CUSTOM_THUMBNAIL",
            );

  Map<String, dynamic> toJson() => {
        'imageKey': imageKey.toJson(),
        'playlistScottyEncryptedBlobId': playlistScottyEncryptedBlobId,
      };
}

class ImageKey {
  final String name;
  final String type;

  const ImageKey({
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
      };
}

class RemoveCustomThumbnailAction extends EditPlaylistAction {
  final String action;
  final DeletedCustomThumbnail deletedCustomThumbnail;

  RemoveCustomThumbnailAction({
    this.action = "ACTION_REMOVE_CUSTOM_THUMBNAIL",
    DeletedCustomThumbnail? deletedCustomThumbnail,
  }) : deletedCustomThumbnail =
            deletedCustomThumbnail ?? DeletedCustomThumbnail();

  @override
  Map<String, dynamic> toJson() => {
        'action': action,
        'deletedCustomThumbnail': deletedCustomThumbnail.toJson(),
      };
}

class DeletedCustomThumbnail {
  final String name;
  final String type;

  const DeletedCustomThumbnail({
    this.name = "studio_square_thumbnail",
    this.type = "PLAYLIST_IMAGE_TYPE_CUSTOM_THUMBNAIL",
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
      };
}
