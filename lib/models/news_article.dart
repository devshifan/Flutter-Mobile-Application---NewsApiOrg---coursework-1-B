class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? urlToImage;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
  });
}
