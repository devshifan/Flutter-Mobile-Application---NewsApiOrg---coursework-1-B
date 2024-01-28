import 'package:flutter/material.dart';
import '../models/news_article.dart';

class ArticleSearchDelegate extends SearchDelegate<NewsArticle> {
  final List<NewsArticle> articles;

  ArticleSearchDelegate(this.articles);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          NewsArticle(
            title: '',
            description: '',
            url: '',
            urlToImage: '',
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  // Widget _buildSearchResults() {
  //   final filteredArticles = articles
  //       .where((article) =>
  //           article.title.toLowerCase().contains(query.toLowerCase()))
  //       .toList();

  //   return ListView.builder(
  //     itemCount: filteredArticles.length,
  //     itemBuilder: (context, index) {
  //       NewsArticle article = filteredArticles[index];
  //       return ListTile(
  //         title: Text(article.title),
  //         subtitle: Text(article.description),
  //         leading: article.urlToImage != null
  //             ? Image.network(article.urlToImage!)
  //             : null,
  //         onTap: () {
  //           // Handle tap on the news article (e.g., navigate to details)
  //         },
  //       );
  //     },
  //   );
  // }
  // Widget _buildSearchResults() {
  //   final filteredArticles = articles
  //       .where((article) =>
  //           article.title.toLowerCase().contains(query.toLowerCase()))
  //       .toList();

  //   return ListView.builder(
  //     itemCount: filteredArticles.length,
  //     itemBuilder: (context, index) {
  //       NewsArticle article = filteredArticles[index];
  //       return Card(
  //         margin: EdgeInsets.only(bottom: 8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             if (article.urlToImage != null)
  //               Image.network(
  //                 article.urlToImage!,
  //                 height: 200, // Adjust the height as needed
  //                 width: double.infinity,
  //                 fit: BoxFit.cover,
  //               ),
  //             ListTile(
  //               title: Text(
  //                 article.title,
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               subtitle: Text(article.description),
  //               leading: article.urlToImage != null
  //                   ? Image.network(article.urlToImage!)
  //                   : null,
  //               onTap: () {
  //                 // Handle tap on the news article (e.g., navigate to details)
  //               },
  //             ),
  //             Divider(
  //               height: 16.0,
  //               color: Colors.grey[400],
  //               thickness: 1.0,
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Widget _buildSearchResults() {
    final filteredArticles = articles
        .where((article) =>
            article.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredArticles.length,
      itemBuilder: (context, index) {
        NewsArticle article = filteredArticles[index];
        return Card(
          margin: EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.urlToImage != null)
                Image.network(
                  article.urlToImage!,
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ListTile(
                title: Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(article.description),
                onTap: () {
                  // Handle tap on the news article (e.g., navigate to details)
                },
              ),
              Divider(
                height: 16.0,
                color: Colors.grey[400],
                thickness: 1.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
