class YouTubeLocale {
  final String gl; // geolocation
  final String hl; // host language

  const YouTubeLocale({
    required this.gl,
    required this.hl,
  });

  Map<String, dynamic> toJson() => {
        'gl': gl,
        'hl': hl,
      };
}
