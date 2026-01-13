import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

extension ByteArrayExtensions on List<int> {
  String toHex() => map((e) => e.toRadixString(16).padLeft(2, '0')).join("");
}

String sha1(String str) {
  var bytes = utf8.encode(str);
  var digest = crypto.sha1.convert(bytes);
  return digest.toString();
}

Map<String, String> parseCookieString(String cookie) {
  return Map.fromEntries(
    cookie.split("; ").where((element) => element.isNotEmpty).map((part) {
      final splitIndex = part.indexOf('=');
      if (splitIndex == -1) return null;
      return MapEntry(
        part.substring(0, splitIndex),
        part.substring(splitIndex + 1),
      );
    }).whereType<MapEntry<String, String>>(),
  );
}

int? parseTime(String str) {
  try {
    final parts = str.split(":").map((e) => int.parse(e)).toList();
    if (parts.length == 2) {
      return parts[0] * 60 + parts[1];
    }
    if (parts.length == 3) {
      return parts[0] * 3600 + parts[1] * 60 + parts[2];
    }
  } catch (e) {
    return null;
  }
  return null;
}

bool isPrivateId(String browseId) {
  return browseId.contains("privately");
}

extension ListFirstOrNull<T> on List<T> {
  T? get firstOrNull => isNotEmpty ? first : null;
  T? get lastOrNull => isNotEmpty ? last : null;
  T? getOrNull(int index) =>
      (index >= 0 && index < length) ? this[index] : null;
}
