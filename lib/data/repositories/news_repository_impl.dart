import 'package:cleannewsapp/data/datasources/local_news_datasource.dart';
import 'package:cleannewsapp/infra/network/networ_info.dart';

import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/remote_news_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final LocalNewsDatasource localDatasource;
  final RemoteNewsDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<List<NewsEntity>> getNewsByCountry(String country) async {
    if (await networkInfo.isConnected) {
        final news = await remoteDatasource.getNewsByCountry(country);

        await localDatasource.cacheNewsByCountry(country: country, news: news);

        return news.map((item) => item.toEntity()).toList();
    } else {
      throw UnimplementedError();
    }
  }
  
}
