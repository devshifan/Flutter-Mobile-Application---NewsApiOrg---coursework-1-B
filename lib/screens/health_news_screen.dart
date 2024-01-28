import 'package:flutter/material.dart';
import 'package:news_app/provider/viewed_news_provider.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/services/health_news_service.dart';
import 'package:news_app/widgets/article_search_delegate.dart';
import 'package:provider/provider.dart';
import '../models/news_article.dart';

class HealthNewsScreen extends StatefulWidget {
  final String category;
  HealthNewsScreen({required this.category});
  @override
  _HealthNewsScreenState createState() => _HealthNewsScreenState();
}

class _HealthNewsScreenState extends State<HealthNewsScreen> {
  final HealthNewsService _newsService = HealthNewsService();
  late List<NewsArticle> _allArticles;
  late List<NewsArticle> _filteredArticles;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _allArticles = [];
    _filteredArticles = [];
    _loadNews();
    Provider.of<ViewedNewsProvider>(context, listen: false)
        .setLastViewedCategory(widget.category);
  }

  Future<void> _loadNews() async {
    try {
      final articles = await _newsService.fetchNews();
      setState(() {
        _allArticles = articles;
        _filteredArticles = articles;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _refreshNews() async {
    setState(() {
      _allArticles.clear();
      _filteredArticles.clear();
      _loading = true;
    });

    await _loadNews();
  }

  void _filterNews(String query) {
    setState(() {
      _filteredArticles = _allArticles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category == 'health' ? 'Health' : ''} News'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ArticleSearchDelegate(_filteredArticles),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/viewed_news');
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshNews,
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildNewsList(),
    );
  }

  Widget _buildNewsList() {
    return _filteredArticles.isNotEmpty
        ? ListView.builder(
            itemCount: _filteredArticles.length,
            itemBuilder: (context, index) {
              NewsArticle article = _filteredArticles[index];
              return GestureDetector(
                onTap: () {
                  _viewNewsDetails(article.title);
                },
                child: Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (article.urlToImage != null)
                        Image.network(article.urlToImage!),
                      ListTile(
                        title: Text(
                          article.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(article.description),
                      ),
                      Divider(
                        height: 16.0,
                        color: Colors.grey[400],
                        thickness: 1.0,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text('No matching articles found'),
          );
  }

  void _viewNewsDetails(String newsTitle) {
    Provider.of<ViewedNewsProvider>(context, listen: false)
        .addViewedNews(widget.category, newsTitle);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NewsDetailsScreen(article: _findArticle(newsTitle)),
      ),
    );
  }

  NewsArticle _findArticle(String newsTitle) {
    return _allArticles.firstWhere((article) => article.title == newsTitle);
  }
}
