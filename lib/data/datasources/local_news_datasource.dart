import 'dart:convert';

import '../../infra/local_storage/local_storage.dart';
import '../../infra/local_storage/local_storage_errors.dart';
import '../models/news_list_model.dart';
import '../models/news_model.dart';

abstract class LocalNewsDatasource {
  Future<void> cacheNewsByCountry({required String country, required List<NewsModel> news});
  Future<List<NewsModel>> getNewsByCountryFromCache({required String country});
}

class LocalNewsDatasourceImpl implements LocalNewsDatasource {
  final LocalStorage localStorage;

  LocalNewsDatasourceImpl(this.localStorage);
  @override
  Future<void> cacheNewsByCountry({required String country, required List<NewsModel> news}) async {
    final newsToJson = NewsListModel(news: news).toJson();
    final json = jsonEncode(newsToJson);
    await localStorage.save<String>(key: country, data: json);
  }

  @override
  Future<List<NewsModel>> getNewsByCountryFromCache({required String country}) async {
    final newsJsonString = await localStorage.get<String>(key: country);
    if (newsJsonString) {
        final news = NewsListModel.fromJson(jsonDecode(newsJsonString)).news;
        return news;
    }
    throw LocalStorageError.cacheError;
  }

}