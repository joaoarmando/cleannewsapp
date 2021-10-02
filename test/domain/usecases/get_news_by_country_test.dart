import 'package:cleannewsapp/domain/entities/news_entity.dart';
import 'package:cleannewsapp/domain/repositories/news_repository.dart';
import 'package:cleannewsapp/domain/usecases/get_news_by_country.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_news_by_country_test.mocks.dart';

@GenerateMocks([NewsRepository])

void main() {

  late MockNewsRepository repository;
  late GetNewsByCountry getNewsByCountry;
  const String tCountry = "any_country";

  setUp(() {
    repository = MockNewsRepository(); 
    getNewsByCountry = GetNewsByCountryImpl(repository);
  });

  test('Should return a list of NewsEntity', () async {
      when(repository.getNewsByCountry(tCountry)).thenAnswer((_) async => <NewsEntity>[]);

      final result = await getNewsByCountry(tCountry);

      expect(result, isA<List<NewsEntity>>());
  });

}