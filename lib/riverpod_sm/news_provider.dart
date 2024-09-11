import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final newsProvider = StateNotifierProvider<NewsNotifier, List<dynamic>>((ref) {
  return NewsNotifier();
});

class NewsNotifier extends StateNotifier<List<dynamic>> {
  NewsNotifier() : super([]);

  Future<void> fetchNews() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fd2473af26bf45808515028c9923b4e3';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    state = json['articles'];
  }
}
