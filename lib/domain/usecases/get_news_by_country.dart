import 'package:cleannewsapp/domain/repositories/news_repository.dart';

import '../entities/news_entity.dart';
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