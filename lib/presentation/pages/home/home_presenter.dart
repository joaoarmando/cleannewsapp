import 'package:mobx/mobx.dart';

abstract class HomePresenter {
  @observable
  bool isLoading = false;

  @observable
  bool internetError = false;

  @observable
  bool unexpectedError = false;

  ObservableList newsList = ObservableList();
  
  Future<void> getNewsByCountry();
  
  void setNewsCountry(String country);
}