import 'package:cleannewsapp/infra/local_storage/local_storage_errors.dart';
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

  @observable
  bool internetError = false;

  ObservableList newsList = ObservableList();

  _HomeControllerBase({required this.newsRepository}) {
    _getNewsByCountry = GetNewsByCountryImpl(newsRepository);
  }

  @action
  Future<void> getNewsByCountry() async {
    internetError = false;
    _changeLoadingStatus(true);
    
    try {
      final news = await _getNewsByCountry(country);
      newsList.addAll(news);
    } on LocalStorageError catch(error) {
      if (error == LocalStorageError.cacheError) {
          internetError = true;
      }
    }

    _changeLoadingStatus(false);
  }

  void _changeLoadingStatus(bool loading) => isLoading = loading;
}