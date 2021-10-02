import 'package:dio/dio.dart';

import 'http_client.dart';
import 'http_errors.dart';
class HttpAdapter implements HttpClient {
  final Dio dio;

  HttpAdapter(this.dio);
  @override
  Future<Map<String,dynamic>> request({required String url, required HttpMethod method}) async {
    
    late Response response;

    try {
      if (method == HttpMethod.get) {
          response = await dio.get(url);
      }
      else { 
        throw UnimplementedError("Method not implemented"); 
      }
    } catch (erorr) {
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  Map<String,dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
        final data =  Map<String, dynamic>.from(response.data);
        return data;
    } else if (response.statusCode == 400) {
        throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
        throw HttpError.unauthorized;
    } else if (response.statusCode == 429) {
        throw HttpError.tooManyRequests;
    } else {
        throw HttpError.serverError;
    }
  }
}