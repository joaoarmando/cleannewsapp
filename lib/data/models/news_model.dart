import '../../domain/entities/news_entity.dart';

class NewsModel {
  final String source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;

  NewsModel({required this.source, 
    required this.author, 
    required this.title, 
    required this.description, 
    required this.url, 
    required this.urlToImage, 
    required this.publishedAt
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: json["source"]["name"],
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.parse(json["publishedAt"])
    );
  }

  Map<String,dynamic> toJson() => {
    "source": {
      "name": source
    },
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
  };

  NewsEntity toEntity() => NewsEntity(
    source: source,
    author: author,
    title: title,
    description: description, 
    url: url,
    urlToImage: urlToImage != null 
      ? urlToImage! 
      : "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg",
    publishedAt: publishedAt
  );
}