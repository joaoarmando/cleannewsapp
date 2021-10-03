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
}