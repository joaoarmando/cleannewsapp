import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/error_message.dart';
import '../../components/internet_error.dart';
import '../../components/loading_indicator.dart';
import 'components/news_card.dart';
import 'home_presenter.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  const HomePage({ Key? key, required this.presenter }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    widget.presenter.getNewsByCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CleanNewsApp"),
      ),
      body: Observer(builder: (_) {

        if (widget.presenter.isLoading) {
          return const Center(
            child: LoadingIndicator(key: Key("loading_key"),)
          );
        } else if (widget.presenter.internetError) {
          return Center(
            child: InternetError(
              key: const Key("internet_error"),
              retry: widget.presenter.getNewsByCountry
            )
          );
        } else if (widget.presenter.unexpectedError) {
          return const Center(
            child: ErrorMessage()
          );
        }

        return ListView.builder(
          key: const Key("news_list_key"),
          itemCount: widget.presenter.newsList.length,
          itemBuilder: (_, index) {
            final news = widget.presenter.newsList[index];
            return NewsCard(news: news);
          }
        );
      },
      ),
    );
  }

}