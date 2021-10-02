import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';
abstract class GetNewsByCountry {
  Future<List<NewsEntity>> call(String country);
}

class GetNewsByCountryImpl implements GetNewsByCountry {
  final NewsRepository repository;

  GetNewsByCountryImpl(this.repository);
  
  @override
  Future<List<NewsEntity>> call(String country) async {
    return await repository.getNewsByCountry(country);
  }

}