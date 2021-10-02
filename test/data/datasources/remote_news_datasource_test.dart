import 'dart:convert';

import 'package:cleannewsapp/data/datasources/remote_news_datasource.dart';
import 'package:cleannewsapp/external/infra/http_adapter.dart';
import 'package:cleannewsapp/external/infra/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';
import 'remote_news_datasource_test.mocks.dart';

@GenerateMocks([HttpAdapter])
void main() {

  late RemoteNewsDatasource remoteDatasource;
  late MockHttpAdapter client;
  late final String url;
  late final String apiKey;
  late final Map<String,dynamic> tNewsResponse;

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
}