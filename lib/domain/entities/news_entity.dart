class NewsEntity {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;

  NewsEntity({required this.source, 
    required this.author, 
    required this.title, 
    required this.description, 
    required this.url, 
    required this.urlToImage, 
    required this.publishedAt
  });

}