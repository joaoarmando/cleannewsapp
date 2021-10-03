import 'dart:convert';

import 'package:cleannewsapp/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  late Map<String,dynamic> newsJson;

  setUp(() {
    newsJson = jsonDecode(fixture("news_model.json"));
  });

  test('Should convert a json in to a News Model', () {
    final newsModel = NewsModel.fromJson(newsJson);

    expect(newsModel.source, newsJson["source"]["name"]);
    expect(newsModel.author, newsJson["author"]);
    expect(newsModel.title, newsJson["title"]);
    expect(newsModel.description, newsJson["description"]);
    expect(newsModel.url, newsJson["url"]);
    expect(newsModel.publishedAt, DateTime.parse(newsJson["publishedAt"]));
  });

  test('Should convert a newsModel into a json', () {
    final newsModel = NewsModel.fromJson(newsJson);

    final json = newsModel.toJson();

    expect(json["source"]["name"], newsModel.source);
    expect(json["author"], newsModel.author);
    expect(json["title"], newsModel.title);
    expect(json["description"], newsModel.description);
    expect(json["url"], newsModel.url);
    expect(json["publishedAt"], newsModel.publishedAt.toIso8601String());
  });

  test('Should convert a newsModel into a NewsEntity', () {
    final newsModel = NewsModel.fromJson(newsJson);

    final newsEntity = newsModel.toEntity();

    expect(newsEntity.source, newsModel.source);
    expect(newsEntity.author, newsModel.author);
    expect(newsEntity.title, newsModel.title);
    expect(newsEntity.description, newsModel.description);
    expect(newsEntity.url, newsModel.url);
    expect(newsEntity.publishedAt, newsModel.publishedAt);
  });

  test('Should set a place holder in case urlToImage is null', () {
    final newsModel = NewsModel.fromJson(newsJson..["urlToImage"] = null);

    final newsEntity = newsModel.toEntity();

    expect(newsEntity.source, newsModel.source);
    expect(newsEntity.author, newsModel.author);
    expect(newsEntity.title, newsModel.title);
    expect(newsEntity.description, newsModel.description);
    expect(newsEntity.url, newsModel.url);
    expect(newsEntity.urlToImage, "https://awlights.com/wp-content/uploads/sites/31/2017/05/placeholder-news.jpg");
    expect(newsEntity.publishedAt, newsModel.publishedAt);
  });
}