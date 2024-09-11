import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/constants/routes.dart';
import 'package:news_app/views/news_view.dart';
import 'package:news_app/views/reading_article_view.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(150, 103, 58, 182),
        ),
        home: const NewsPage(),
        routes: {
          readingArticleView: (context) => const ReadingArticle(data: null),
        },
      ),
    ),
  );
}
