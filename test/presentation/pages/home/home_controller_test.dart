import 'package:cleannewsapp/domain/entities/news_entity.dart';
import 'package:cleannewsapp/domain/repositories/news_repository.dart';
import 'package:cleannewsapp/presentation/pages/home/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/usecases/get_news_by_country_test.mocks.dart';

@GenerateMocks([NewsRepository])
void main() {
  late String newsCountry;
  late HomeController controller;
  late NewsRepository repository;
  late NewsEntity tNewsEntity;

  setUp(() {
    repository = MockNewsRepository();
    controller = HomeController(newsRepository: repository);

    newsCountry = "any_country";
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
  });

  test('Should add NewsEntity into a newsList', () async {
    when(repository.getNewsByCountry(newsCountry)).thenAnswer((_) async => [tNewsEntity]);

    expect(controller.newsList.length, 0);

    await controller.getNewsByCountry();

    expect(controller.newsList.length, 1);
    expect(controller.newsList.contains(tNewsEntity), true);
  });
}