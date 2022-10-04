import 'dart:io';
import 'package:anime_quotes/navigation/navi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = PostHttpOverrides();
  runApp(
    const ProviderScope(
      //No MaterialLocalizations found if no Material App here
      child: Navi(),
    ),
  );
}
