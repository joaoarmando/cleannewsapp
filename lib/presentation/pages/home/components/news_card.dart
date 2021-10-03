import 'package:flutter/material.dart';

import '../../../../domain/entities/news_entity.dart';
import '../../../components/cached_image.dart';
import '../../../components/subtitle1.dart';
import '../../../components/subtitle2.dart';

class NewsCard extends StatelessWidget {
  final NewsEntity news;
  const NewsCard({ Key? key, required this.news }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 10),
            blurRadius: 30,
          ),
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedImage(news.urlToImage, 
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12,12,12,0),
            child: SubTitle1(news.title),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12,6,12,6),
            child: SubTitle2(news.source),
          ),
        ],
      ),
    );
  }
}