import 'package:cleannewsapp/presentation/components/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/src/provider.dart';

import '../../../data/datasources/local_news_datasource.dart';
import '../../../data/datasources/remote_news_datasource.dart';
import '../../../data/repositories/news_repository_impl.dart';
import '../../../domain/repositories/news_repository.dart';
import '../../../infra/http/http_adapter.dart';
import '../../../infra/local_storage/local_storage_adapter.dart';
import '../../../infra/network/network_info.dart';
import '../../components/internet_error.dart';
import '../../components/loading_indicator.dart';
import 'components/news_card.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController homeController;
  late NewsRepository newsRepository;

  @override
  void initState() {
    _setupPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CleanNewsApp"),
      ),
      body: Observer(builder: (_) {

        if (homeController.isLoading) {
          return const Center(
            child:LoadingIndicator()
          );
        } else if (homeController.internetError) {
          return Center(
            child: InternetError(retry: homeController.getNewsByCountry)
          );
        } else if (homeController.unexpectedError) {
          return const Center(
            child: ErrorMessage()
          );
        }

        return ListView.builder(
          itemCount: homeController.newsList.length,
          itemBuilder: (_, index) {
            final news = homeController.newsList[index];
            return NewsCard(news: news);
          }
        );
      },
      ),
    );
  }

  void _setupPage() {
    final localStorage = context.read<LocalStorageAdapter>();
    final httpAdapter = context.read<HttpAdapter>();
    final networkInfo = context.read<NetworkInfoImpl>();

    newsRepository = NewsRepositoryImpl(
      localDatasource: LocalNewsDatasourceImpl(localStorage), 
      remoteDatasource: RemoteNewsDatasourceImpl(
        client: httpAdapter,
        url: "https://newsapi.org/v2/top-headlines", 
        apiKey: "6656033934ad435aa21cecb22fe5f60b"
      ), 
      networkInfo: networkInfo,
    );

    homeController = HomeController(newsRepository: newsRepository);
    homeController.getNewsByCountry();
  }

}