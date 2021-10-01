import 'dart:convert';
import 'package:cleannewsapp/external/infra/http_adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../fixtures/fixture_reader.dart';
import 'http_adapter_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio dio;
  late DioAdapter dioAdapter;
  late HttpAdapter client;
  final tNewsResponse = jsonDecode(fixture("news_response.json"));

  setUp(() {
    dio = MockDio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    client = HttpAdapter(dio);
  });

  void _mockDioResponseOnGet({
    required String url,
    required int statusCode,
    required Map response}) { 
      // return dioAdapter.onGet(url,
      //   (server) => server.reply(statusCode, response));
      return when(dio.get(url)).thenAnswer((_) 
        async => Response(statusCode: statusCode, data: response, requestOptions: RequestOptions(path: url))
      );
  }

  test('Should call Dio with the correct method', () async {
    _mockDioResponseOnGet(url: 'any_url', statusCode: 200, response: {"any_key": "any_value"});

    await client.get(url: "any_url");

    verify(dio.get("any_url"));
  });
}