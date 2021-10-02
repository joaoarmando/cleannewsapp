import 'dart:convert';

import 'package:cleannewsapp/data/datasources/remote_news_datasource.dart';
import 'package:cleannewsapp/domain/errors/domain_error.dart';
import 'package:cleannewsapp/infra/http/http_adapter.dart';
import 'package:cleannewsapp/infra/http/http_client.dart';
import 'package:cleannewsapp/infra/http/http_errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'remote_news_datasource_test.mocks.dart';

@GenerateMocks([HttpAdapter])
void main() {

  late RemoteNewsDatasource remoteDatasource;
  late MockHttpAdapter client;
  late String url;
  late String apiKey;
  late Map<String,dynamic> tNewsResponse;

  setUp(() {
    client = MockHttpAdapter();
    url = "any_url";
    apiKey = "any_api_key";
    tNewsResponse = jsonDecode(fixture("news_response.json"));
    remoteDatasource = RemoteNewsDatasourceImpl(
      client: client, 
      url: url, 
      apiKey: apiKey
    );
  });

  test('Should return a list of NewsModel by given a json response', () async {
    when(client.request(url: anyNamed("url"), method: HttpMethod.get)).thenAnswer((_) async => tNewsResponse);

    final result = await remoteDatasource.getNewsByCountry("any_country");

    expect(result.length, greaterThan(0));
    expect(result[0].url, equals(tNewsResponse["articles"][0]["url"]));
    expect(result[0].title, equals(tNewsResponse["articles"][0]["title"]));
  });

  test('Should throws DomainError.tryAgainLater on HttpError.tooManyRequests', () {
    when(client.request(url: anyNamed("url"), method: HttpMethod.get)).thenThrow(HttpError.tooManyRequests);

    final future = remoteDatasource.getNewsByCountry("any_country");

    expect(future, throwsA(DomainError.tryAgainLater));
  });

  test('Should throws DomainError.unexcepted on HttpError.badRequest', () {
    when(client.request(url: anyNamed("url"), method: HttpMethod.get)).thenThrow(HttpError.badRequest);

    final future = remoteDatasource.getNewsByCountry("any_country");

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throws DomainError.unexcepted on HttpError.serverError', () {
    when(client.request(url: anyNamed("url"), method: HttpMethod.get)).thenThrow(HttpError.serverError);

    final future = remoteDatasource.getNewsByCountry("any_country");

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throws DomainError.unexcepted on HttpError.unauthorized', () {
    when(client.request(url: anyNamed("url"), method: HttpMethod.get)).thenThrow(HttpError.unauthorized);

    final future = remoteDatasource.getNewsByCountry("any_country");

    expect(future, throwsA(DomainError.unexpected));
  });
}