import 'package:innertube_dart/innertube_dart.dart';

void main() async {
  final yt = YouTube();

  print('--- Searching "faded" ---');
  final searchResult = await yt.search("faded");
  if (searchResult != null) {
    for (var item in searchResult.items) {
      if (item is SongItem) {
        print(
            'Song: ${item.title} by ${item.artists.map((a) => a.name).join(", ")}');
      } else if (item is ArtistItem) {
        print('Artist: ${item.title}');
      }
    }
  }

  print('\n--- Fetching Home Page ---');
  final home = await yt.fromHome();
  if (home != null) {
    for (var section in home.sections) {
      print('Section: ${section.title} - ${section.items.length} items');
    }
  }
}
