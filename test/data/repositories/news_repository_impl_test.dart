import 'package:cleannewsapp/data/datasources/remote_news_datasource.dart';
import 'package:cleannewsapp/data/models/news_model.dart';
import 'package:cleannewsapp/data/repositories/news_repository_impl.dart';
import 'package:cleannewsapp/domain/entities/news_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteNewsDatasource])

void main() {
  late RemoteNewsDatasource remoteDatasource;
  late NewsRepositoryImpl repository;

  setUp(() {
    remoteDatasource = MockRemoteNewsDatasource();
    repository = NewsRepositoryImpl(remoteDatasource: remoteDatasource);
  });

  test('Should return a list of NewsEntity', () async {
    //arrange
      when(remoteDatasource.getNewsByCountry("any_country")).thenAnswer((_) async => <NewsModel>[]);
    //act
      final result = await repository.getNewsByCountry("any_country");
    //assert
      expect(result, isA<List<NewsEntity>>());
  });
}