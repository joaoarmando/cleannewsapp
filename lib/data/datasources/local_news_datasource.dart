import 'package:cleannewsapp/data/models/news_model.dart';

abstract class LocalNewsDatasource {
  Future<void> cacheNewsByCountry({required String country, required List<NewsModel> news});
}

class LocalNewsDatasourceImpl implements LocalNewsDatasource {
  @override
  Future<void> cacheNewsByCountry({required String country, required List<NewsModel> news}) {
    // TODO: implement cacheNewsByCountry
    throw UnimplementedError();
  }

}