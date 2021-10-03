import 'dart:convert';
import 'package:cleannewsapp/data/datasources/local_news_datasource.dart';
import 'package:cleannewsapp/data/models/news_list_model.dart';
import 'package:cleannewsapp/infra/local_storage/local_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'local_news_datasource_test.mocks.dart';

@GenerateMocks([LocalStorage])
void main() {
  late String tCountry;
  late NewsListModel tNewsListModel;
  late LocalStorage localStorage;
  late LocalNewsDatasource localDatasource;

  setUp(() {
    tCountry = "br";
    tNewsListModel = NewsListModel.fromJson(jsonDecode(fixture("news_list.json")));
    localStorage = MockLocalStorage();
    localDatasource = LocalNewsDatasourceImpl(localStorage);
  });

  test('Should cache a list of news using the country as key', () {
      localDatasource.cacheNewsByCountry(country: tCountry, news: tNewsListModel.news);

      verify(localStorage.save<String>(key: tCountry, data: jsonEncode(tNewsListModel.toJson())));
  });
}