import 'package:anime_quotes/view/anime_list.dart';
import 'package:anime_quotes/view/character.dart';
import 'package:anime_quotes/view/random.dart';
import 'package:anime_quotes/view/title_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Navi extends ConsumerWidget {
  const Navi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "Anime Quotes",
      routes: {
        '/': (context) => const RandomQuote(),
        '/list': (context) => const AnimeList(),
        '/title': (context) => const TitleQuote(),
        '/character': (context) => const CharacterQuote(),
      },
    );
  }
}
