import 'package:fpdart/fpdart.dart';

import '../entities/news_entity.dart';
import '../errors/domain_error.dart';

abstract class NewsRepository {
  Future<Either<DomainError, List<NewsEntity>>> getNewsByCountry(String country);
}