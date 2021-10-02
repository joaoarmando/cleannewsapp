import 'package:cleannewsapp/external/infra/http_adapter.dart';
import 'package:cleannewsapp/external/infra/http_client.dart';

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
   
      final response = await client.request(url: endpoint, method: HttpMethod.get);

      final articles = response["articles"] as List;

      final news = articles.map((item) => NewsModel.fromJson(item)).toList();

      return news;
      


  }

}