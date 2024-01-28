import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class ScienceNewsService {
  final String apiKey =
      'fcb4987995f14ff4b302da24e50e8ee2'; // Get your API key from newsapi.org
  final String? category;

  ScienceNewsService({this.category});

  Future<List<NewsArticle>> fetchNews() async {
    try {
      final Uri url = Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=fcb4987995f14ff4b302da24e50e8ee2');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        return articles
            .map((article) => NewsArticle(
                  title: article['title'] ?? 'No Title',
                  description: article['description'] ?? 'No Description',
                  url: article['url'] ?? '',
                  urlToImage: article['urlToImage'] ?? '',
                ))
            .toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
