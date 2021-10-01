class NewsEntity {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;

  NewsEntity(this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt);
}