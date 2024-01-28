import 'package:flutter/material.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/provider/viewed_news_provider.dart';
import 'package:provider/provider.dart';

class ViewedNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String lastViewedCategory =
        Provider.of<ViewedNewsProvider>(context).getLastViewedCategory();

    List<String> viewedNews = Provider.of<ViewedNewsProvider>(context)
        .getViewedNewsForCategory(lastViewedCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recently Viewed News'),
      ),
      body: viewedNews.isNotEmpty
          ? ListView.builder(
              itemCount: viewedNews.length,
              itemBuilder: (context, index) {
                String newsTitle = viewedNews[index];
                NewsArticle? article = _findArticle(newsTitle);

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(newsTitle),
                    leading: article?.urlToImage != null
                        ? Image.network(
                            article!.urlToImage!,
                            width: 50, // Adjust the width as needed
                            height: 50, // Adjust the height as needed
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                );
              },
            )
          : Center(
              child: Text('No recently viewed news'),
            ),
    );
  }

  NewsArticle? _findArticle(String newsTitle) {
    return null;
  }
}
