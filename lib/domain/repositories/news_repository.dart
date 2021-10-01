import '../entities/news_entity.dart';

abstract class NewsRepository {
  Future<List<NewsEntity>> getNewsByCountry(String country);
}