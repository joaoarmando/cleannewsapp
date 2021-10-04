import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/local_news_datasource.dart';
import '../../data/datasources/remote_news_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../infra/http/http_adapter.dart';
import '../../infra/local_storage/local_storage_adapter.dart';
import '../../infra/network/network_info.dart';
import '../pages/home/home_controller.dart';
import '../pages/home/home_page.dart';
import '../pages/home/home_presenter.dart';

class App extends StatelessWidget {
  final SharedPreferences prefs;
  const App({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final LocalStorageAdapter localStorageAdapter = LocalStorageAdapter(prefs);
    final HttpAdapter httpAdapter = HttpAdapter(Dio());
    final NetworkInfoImpl networkInfo = NetworkInfoImpl(InternetConnectionChecker());

    const primaryColor = Color(0xff007AFF);
    const primaryColorDark = Color(0xff0060C9);
    const primaryColorLight = Color(0xff3190F7);

    return MultiProvider(
      providers: [
        Provider<LocalStorageAdapter>(create: (_) => localStorageAdapter),
        Provider<HttpAdapter>(create: (_) => httpAdapter),
        Provider<NetworkInfoImpl>(create: (_) => networkInfo),
      ],
      child: MaterialApp(
        title:'Clean News App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.5,
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )
          ),
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark,
          primaryColorLight: primaryColorLight,
          colorScheme: const ColorScheme.light(primary: primaryColor),
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            subtitle1: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black
            ),
            subtitle2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Color(0xff57546A)
            ),
          ),
        ),
        home: HomePage(presenter: makeHomePresenter(
          localStorageAdapter: localStorageAdapter, 
          httpAdapter: httpAdapter, 
          networkInfo: networkInfo
        )),
      ),
    );
  }

  HomePresenter makeHomePresenter({required LocalStorageAdapter localStorageAdapter, 
    required HttpAdapter httpAdapter, required NetworkInfo networkInfo}) {
      final newsRepository = NewsRepositoryImpl(
        localDatasource: LocalNewsDatasourceImpl(localStorageAdapter), 
        remoteDatasource: RemoteNewsDatasourceImpl(
          client: httpAdapter,
          url: "https://newsapi.org/v2/top-headlines", 
          apiKey: "6656033934ad435aa21cecb22fe5f60b"
        ), 
        networkInfo: networkInfo,
      );

      return HomeController(newsRepository: newsRepository);
  }
}