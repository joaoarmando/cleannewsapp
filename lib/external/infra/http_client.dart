enum HttpMethod {get}

abstract class HttpClient {
  Future<Map<String,dynamic>> request({required String url, required HttpMethod method});
}