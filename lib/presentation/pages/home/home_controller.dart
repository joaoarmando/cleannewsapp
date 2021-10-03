import 'package:mobx/mobx.dart';

import '../../../domain/repositories/news_repository.dart';
import '../../../domain/usecases/get_news_by_country.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  String country = "br";
  late final NewsRepository newsRepository;
  late final GetNewsByCountry _getNewsByCountry;

  @observable
  bool isLoading = false;

  ObservableList newsList = ObservableList();

  _HomeControllerBase({required this.newsRepository}) {
    _getNewsByCountry = GetNewsByCountryImpl(newsRepository);
  }

  @action
  Future<void> getNewsByCountry() async {
    _changeLoadingStatus(true);

    final news = await _getNewsByCountry(country);
    newsList.addAll(news);

    _changeLoadingStatus(false);
  }

  void _changeLoadingStatus(bool loading) => isLoading = loading;
}