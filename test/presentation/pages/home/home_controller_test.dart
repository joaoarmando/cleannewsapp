import 'package:cleannewsapp/domain/entities/news_entity.dart';
import 'package:cleannewsapp/domain/repositories/news_repository.dart';
import 'package:cleannewsapp/infra/local_storage/local_storage_errors.dart';
import 'package:cleannewsapp/presentation/pages/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/usecases/get_news_by_country_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late String newsCountry;
  late HomeController controller;
  late NewsRepository repository;
  late NewsEntity tNewsEntity;

  PostExpectation _mockRepositoryRequest()
   =>  when(repository.getNewsByCountry(newsCountry));

  void _mockRepositoryResponse()
   => _mockRepositoryRequest().thenAnswer((_) async => [tNewsEntity]);

  void _mockRepositoryException(dynamic excpetion) 
    => _mockRepositoryRequest().thenThrow(excpetion);

  setUp(() {
    newsCountry = "any_country";
    repository = MockNewsRepository();
    controller = HomeController(newsRepository: repository);
    controller.setNewsCountry(newsCountry);
    tNewsEntity = NewsEntity(
      source: "any_source",
      author: "any_author",
      title: "any_title",
      description: "any_description",
      url: "any_url",
      urlToImage: "any_urlToImage",
      publishedAt: DateTime.now()
    );
    _mockRepositoryResponse();
  });

  test('Should set the news country correctly', () {
    controller.setNewsCountry("another_country");

    expect(controller.country, "another_country");
  });

  test('Should add NewsEntity into a newsList', () async {
    expect(controller.newsList.length, 0);

    await controller.getNewsByCountry();

    expect(controller.newsList.length, 1);
    expect(controller.newsList.contains(tNewsEntity), true);
  });

  test('Should set isLoading as true while retrieving data and false at the end', () async {
    final emitedLoadingStates = [];
    
    final dispose = mobx.reaction((_) => controller.isLoading, (newValue) => emitedLoadingStates.add(newValue));

    await controller.getNewsByCountry();
    expect(emitedLoadingStates, equals([true,false]));
    dispose();
  });


  group('InternetError', () {

    test('Should set internetError as false while retrieving data', () async {
      controller.internetError = true;
      final emitedInternetErrorStates = [];    
      final dispose = mobx.reaction((_) => controller.internetError, (newValue) => emitedInternetErrorStates.add(newValue));

      await controller.getNewsByCountry();

      expect(emitedInternetErrorStates, [false]);
      dispose();
    });

    test('Should set internetError as true when has no internet connection', () async {
      _mockRepositoryException(LocalStorageError.cacheError);

      await controller.getNewsByCountry();

      expect(controller.internetError, true);
    });

    test('Should set internetError as false when a list of NewsEntity is returned', () async {
      controller.internetError = true;

      await controller.getNewsByCountry();

      expect(controller.internetError, false);
    });

  });

  group('unexpectedError', () {
    test('Should set unexpectedError as true when an occurs', () async {
      _mockRepositoryException(Exception());

      await controller.getNewsByCountry();

      expect(controller.unexpectedError, true);
    });

    test('Should set unexpectedError as false when a list of NewsEntity is returned', () async {
      controller.unexpectedError = true;

      await controller.getNewsByCountry();

      expect(controller.unexpectedError, false);
    });

  });


}