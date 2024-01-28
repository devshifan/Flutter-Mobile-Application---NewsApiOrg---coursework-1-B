import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/news_article.dart';

class NewsDetailsScreen extends StatefulWidget {
  final NewsArticle article;

  NewsDetailsScreen({required this.article});

  @override
  _NewsDetailsScreenState createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  FlutterTts flutterTts = FlutterTts();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.speaker),
            onPressed: () {
              _announceDetails();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.article.urlToImage != null)
              Image.network(widget.article.urlToImage!),
            SizedBox(height: 16.0),
            Text(
              widget.article.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              widget.article.description,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Source: ${widget.article.url}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _announceDetails() async {
    String announcement =
        'Article Details: ${widget.article.title}. ${widget.article.description}. Source: ${widget.article.url}';

    await flutterTts.speak(announcement);
  }
}
