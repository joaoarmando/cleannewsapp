import 'package:cleannewsapp/data/datasources/local_news_datasource.dart';
import 'package:cleannewsapp/data/datasources/remote_news_datasource.dart';
import 'package:cleannewsapp/data/models/news_model.dart';
import 'package:cleannewsapp/data/repositories/news_repository_impl.dart';
import 'package:cleannewsapp/infra/network/networ_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_repository_impl_test.mocks.dart';

@GenerateMocks([LocalNewsDatasource, RemoteNewsDatasource, NetworkInfo])

void main() {
  late RemoteNewsDatasource remoteDatasource;
  late LocalNewsDatasource localDatasource;
  late NetworkInfo networkInfo;
  late NewsRepositoryImpl repository;

  _mockNetworkInfo({bool hasConnection = true})
    => when(networkInfo.isConnected).thenAnswer((_) async => hasConnection);

  _mockExpectedRemoteDatasourceResponse()
    => when(remoteDatasource.getNewsByCountry("any_country")).thenAnswer((_) async => <NewsModel>[]);  

  _mockExpectedLocalDatasourceResponse()
    => when(localDatasource.getNewsByCountryFromCache(country: "any_country")).thenAnswer((_) async => <NewsModel>[]);  

  setUp(() {
    remoteDatasource = MockRemoteNewsDatasource();
    localDatasource = MockLocalNewsDatasource();
    networkInfo = MockNetworkInfo();
    repository = NewsRepositoryImpl(
      localDatasource: localDatasource,
      remoteDatasource: remoteDatasource,
      networkInfo: networkInfo
    );
  });

  group('Device is online', () {

    setUp(() {
      _mockNetworkInfo();
      _mockExpectedRemoteDatasourceResponse();
    });

    test('Should call remoteNewsDatasource if has internet connection', () async {
      await repository.getNewsByCountry("any_country");

      verify(remoteDatasource.getNewsByCountry("any_country"));
    });

    test('Should cache a list of news after receive a response from the api', () async {
      await repository.getNewsByCountry("any_country");

      verify(localDatasource.cacheNewsByCountry(country: "any_country", news: <NewsModel>[]));
    });

  });

  group('Device is offline', () {

    setUp(() {
      _mockNetworkInfo(hasConnection: false);
      _mockExpectedLocalDatasourceResponse();
    });

    test('Should call localNewsDatasource if has no internet connection', () async {
      await repository.getNewsByCountry("any_country");

      verify(localDatasource.getNewsByCountryFromCache(country: "any_country"));
    });

  });

}