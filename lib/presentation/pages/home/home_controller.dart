import 'package:cleannewsapp/domain/errors/domain_error.dart';
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

    final domainErrorOrNews = await _getNewsByCountry(country);

    domainErrorOrNews.fold(
      (domainError) => domainError == DomainError.noInternetConnection 
        ? _changeInternetErrorStatus(true) 
        : _changeUnexpectedErrorStatus(true), 
      (news) => newsList.addAll(news)
    );

    _changeLoadingStatus(false);
  }

  @action
  void setNewsCountry(String newsCountry) => country = newsCountry; 

  void _changeLoadingStatus(bool loading) => isLoading = loading;

  void _changeInternetErrorStatus(bool hasError) => internetError = hasError;

  void _changeUnexpectedErrorStatus(bool hasError) => unexpectedError = hasError;
}