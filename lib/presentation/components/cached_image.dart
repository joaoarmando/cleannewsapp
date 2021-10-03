import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  const CachedImage(this.imageUrl, { Key? key, this.height }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: height,
    );
  }
}