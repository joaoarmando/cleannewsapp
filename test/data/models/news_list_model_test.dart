import 'dart:convert';

import 'package:cleannewsapp/data/models/news_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  late Map<String,dynamic> newsListJson;

  setUp(() {
    newsListJson = jsonDecode(fixture("news_list.json"));
  });
  
  test('Should convert a json into a NewsListModel', () {
    final newsList = NewsListModel.fromJson(newsListJson);

    expect(newsList.news.length, greaterThan(1));
    expect(newsList.news[0].title, newsListJson["news"][0]["title"]);
  });
}