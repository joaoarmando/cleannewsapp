import '../models/news_model.dart';

abstract class RemoteNewsDatasource {
  Future<List<NewsModel>> getNewsByCountry(String country);
}