import 'news_model.dart';

class NewsListModel {
  final List<NewsModel> news;
  NewsListModel({required this.news});

  factory NewsListModel.fromJson(Map<String,dynamic> json) => NewsListModel(
    news: List<NewsModel>.from(json['news'].map((x) => NewsModel.fromJson(x))),
  );

  Map<String,dynamic> toJson() => {
    "newsList": news.map((item) => item.toJson()).toList()
  };
}