import 'package:cleannewsapp/external/infra/http_adapter.dart';
import 'package:cleannewsapp/external/infra/http_client.dart';
import 'package:cleannewsapp/external/infra/http_errors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'http_adapter_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio dio;
  late DioAdapter dioAdapter;
  late HttpAdapter client;
  const String url = "any_url";
  const tApiResponse = {"any_key": "any_value"};

  PostExpectation _mockRequest() => when(dio.get(url));

  void _mockResponse({required int statusCode, Map<String,dynamic> data = tApiResponse}) {
    final response = Response(
      statusCode: statusCode,
      data: data, 
      requestOptions: RequestOptions(path: url),
    );

    _mockRequest().thenAnswer((_) async => response);
  }

  setUp(() {
    dio = MockDio();
    dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;
    client = HttpAdapter(dio);
    _mockResponse(statusCode: 200);
  });

  
  test('Should call Dio with the correct method', () async {
    await client.request(url: url, method: HttpMethod.get);

    verify(dio.get(url));
  });

  test('Should return a map from the body of the response', () async {
    final response = await client.request(url: url, method: HttpMethod.get);

    expect(response["any_key"], tApiResponse["any_key"]);
  });

  test('Should throws a badRequest on 400', () async {
    _mockResponse(statusCode: 400);

    final future = client.request(url: url, method: HttpMethod.get);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should throws a unauthorized on 401', () async {
    _mockResponse(statusCode: 401);

    final future = client.request(url: url, method: HttpMethod.get);

    expect(future, throwsA(HttpError.unauthorized));
  });

  test('Should throws a tooManyRequests on 429', () async {
    _mockResponse(statusCode: 429);

    final future = client.request(url: url, method: HttpMethod.get);

    expect(future, throwsA(HttpError.tooManyRequests));
  });

  test('Should throws a ServerError on 500 or any other status code not handled', () async {
    _mockResponse(statusCode: 500);

    final future = client.request(url: url, method: HttpMethod.get);

    expect(future, throwsA(HttpError.serverError));
  });
}