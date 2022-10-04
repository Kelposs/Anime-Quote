class Anime {
  final String anime;
  final String character;
  final String quote;

  Anime({
    required this.anime,
    required this.character,
    required this.quote,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      anime: json['anime'],
      character: json['character'],
      quote: json['quote'],
    );
  }
}
