import '../../domain/errors/domain_error.dart';
import '../../infra/http/http_adapter.dart';
import '../../infra/http/http_client.dart';
import '../../infra/http/http_errors.dart';
import '../models/news_model.dart';

abstract class RemoteNewsDatasource {
  Future<List<NewsModel>> getNewsByCountry(String country);
}

class RemoteNewsDatasourceImpl implements RemoteNewsDatasource {
  final HttpAdapter client;
  final String url;
  final String apiKey;
  
  RemoteNewsDatasourceImpl({
    required this.client,
    required this.url,
    required this.apiKey
  });

  @override
  Future<List<NewsModel>> getNewsByCountry(String country) async {
    final endpoint = "$url?country=$country&apiKey=$apiKey";

    try {
      final response = await client.request(url: endpoint, method: HttpMethod.get);

      final articles = response["articles"] as List;

      final news = articles.map((item) => NewsModel.fromJson(item)).toList();

      return news;
    } on HttpError catch(error) {
      
      if (error == HttpError.tooManyRequests) {
          throw DomainError.tryAgainLater;
      }

      throw DomainError.unexpected;
    }
  }
}