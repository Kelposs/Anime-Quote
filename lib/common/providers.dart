import 'dart:convert';

import 'package:anime_quotes/common/const.dart';
import 'package:anime_quotes/model/anime.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = StateProvider<String>((ref) {
  return randomQts;
});

final actionProvider = StateProvider<AutoDisposeFutureProvider>((ref) {
  return randomQuote;
});

final allAnimation = FutureProvider.autoDispose(
  (ref) async {
    final response = await http.get(Uri.parse('$baseUrl/available/anime'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load animation titles');
    }
  },
);

final randomQuote = FutureProvider.autoDispose(
  (ref) async {
    final response = await http.get(Uri.parse('$baseUrl/random'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Anime.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load random quote');
    }
  },
);

final getRandomByTitle = FutureProvider.family.autoDispose(
  (ref, title) async {
    final response =
        await http.get(Uri.parse('$baseUrl/quotes/anime?title=$title'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Anime>((json) => Anime.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load random quote');
    }
  },
);

final getRandomByCharacter = FutureProvider.family.autoDispose(
  (ref, name) async {
    final response =
        await http.get(Uri.parse('$baseUrl/quotes/character?name=$name'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Anime>((json) => Anime.fromJson(json)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load random quote');
    }
  },
);
