import 'package:mobx/mobx.dart';

import '../../../domain/repositories/news_repository.dart';
import '../../../domain/usecases/get_news_by_country.dart';
import '../../../infra/local_storage/local_storage_errors.dart';
import 'home_presenter.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController implements HomePresenter;

abstract class _HomeControllerBase with Store{
  String country = "us";
  late final NewsRepository newsRepository;
  late final GetNewsByCountry _getNewsByCountry;

  @observable
  bool isLoading = false;

  @observable
  bool internetError = false;

  @observable
  bool unexpectedError = false;

  ObservableList newsList = ObservableList();

  _HomeControllerBase({required this.newsRepository}) {
    _getNewsByCountry = GetNewsByCountryImpl(newsRepository);
  }

  @action
  Future<void> getNewsByCountry() async {
    _changeUnexpectedErrorStatus(false);
    _changeInternetErrorStatus(false);
    _changeLoadingStatus(true);

    try {
      final news = await _getNewsByCountry(country);
      newsList.addAll(news);
    } on LocalStorageError catch(error) {
      if (error == LocalStorageError.cacheError) {
          _changeInternetErrorStatus(true);
      }
    } catch (anyError) {
      _changeUnexpectedErrorStatus(true);
    }

    _changeLoadingStatus(false);
  }

  @action
  void setNewsCountry(String newsCountry) => country = newsCountry; 

  void _changeLoadingStatus(bool loading) => isLoading = loading;

  void _changeInternetErrorStatus(bool hasError) => internetError = hasError;

  void _changeUnexpectedErrorStatus(bool hasError) => unexpectedError = hasError;
}