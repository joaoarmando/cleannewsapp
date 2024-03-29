import '../../domain/entities/news_entity.dart';
import '../../domain/errors/domain_error.dart';
import '../../domain/repositories/news_repository.dart';
import '../../infra/local_storage/local_storage_errors.dart';
import '../../infra/network/network_info.dart';
import '../datasources/local_news_datasource.dart';
import '../datasources/remote_news_datasource.dart';
import '../models/news_model.dart';

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
    late final List<NewsModel> news;
    try {
      if (await networkInfo.isConnected) {
          news = await remoteDatasource.getNewsByCountry(country);

          await localDatasource.cacheNewsByCountry(country: country, news: news);
      } else {
          news = await localDatasource.getNewsByCountryFromCache(country: country);
      }

      return news.map((item) => item.toEntity()).toList();

    } on LocalStorageError catch (error) {
      if (error == LocalStorageError.cacheError) {
          throw DomainError.noInternetConnection;
      } else {
        throw DomainError.unexpected;
      }
    }    
  }
  
}
