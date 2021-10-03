import 'package:flutter/material.dart';

class SubTitle2 extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const SubTitle2(this.text, { Key? key, this.textAlign = TextAlign.start }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}