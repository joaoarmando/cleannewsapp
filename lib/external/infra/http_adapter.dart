import 'package:dio/dio.dart';

import 'http_client.dart';

class HttpAdapter implements HttpClient {
  final Dio dio;

  HttpAdapter(this.dio);
  @override
  Future<Map<String,dynamic>> get({required String url}) async {
    
    Response response = await dio.get(url);

    if (response.statusCode == 200) {
        final body = response.data;
        return {};
    }
    throw Exception();
  }

}