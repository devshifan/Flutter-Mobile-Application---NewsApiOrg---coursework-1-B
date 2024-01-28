// news_type_screen.dart

import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsTypeScreen extends StatefulWidget {
  @override
  _NewsTypeScreenState createState() => _NewsTypeScreenState();
}

class _NewsTypeScreenState extends State<NewsTypeScreen> {
  final NewsService _newsService = NewsService(category: 'business');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<NewsArticle>>(
          future: _newsService.fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading news'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No business news available'),
              );
            } else {
              List<NewsArticle> articles = snapshot.data!;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  NewsArticle article = articles[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        article.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (article.urlToImage != null)
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(article.urlToImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onTap: () {
                        // Open the article in a browser or detailed view
                        // You can navigate to a new screen or open a web page
                        // based on the article's URL.
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
