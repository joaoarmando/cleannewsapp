import 'package:cleannewsapp/data/datasources/remote_news_datasource.dart';

import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final RemoteNewsDatasource remoteDatasource;

  NewsRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<NewsEntity>> getNewsByCountry(String country) async {
    final news = await remoteDatasource.getNewsByCountry(country);

    return news.map((item) => item.toEntity()).toList();
  }
  
}
