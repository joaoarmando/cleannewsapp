import 'dart:convert';

import '../../infra/local_storage/local_storage.dart';
import '../models/news_list_model.dart';
import '../models/news_model.dart';

abstract class LocalNewsDatasource {
  Future<void> cacheNewsByCountry({required String country, required List<NewsModel> news});
}

class LocalNewsDatasourceImpl implements LocalNewsDatasource {
  final LocalStorage localStorage;

  LocalNewsDatasourceImpl(this.localStorage);
  @override
  Future<void> cacheNewsByCountry({required String country, required List<NewsModel> news}) async {
    final newsToJson = NewsListModel(newsList: news).toJson();
    final json = jsonEncode(newsToJson);
    await localStorage.save<String>(key: country, data: json);
  }

}