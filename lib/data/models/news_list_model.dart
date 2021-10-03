import 'news_model.dart';

class NewsListModel {
  final List<NewsModel> newsList;
  NewsListModel({required this.newsList});

  factory NewsListModel.fromJson(Map<String,dynamic> json) => NewsListModel(
    newsList: List<NewsModel>.from(json['newsList'].map((x) => NewsModel.fromJson(x))),
  );

  Map<String,dynamic> toJson() => {
    "newsList": newsList.map((item) => item.toJson()).toList()
  };
}