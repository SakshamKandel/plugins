import '../context.dart';

class SubscribeBody {
  final List<String> channelIds;
  final Context context;

  const SubscribeBody({
    required this.channelIds,
    required this.context,
  });

  Map<String, dynamic> toJson() => {
        'channelIds': channelIds,
        'context': context.toJson(),
      };
}
