import 'package:flutter/material.dart';

class SubTitle2 extends StatelessWidget {
  final String text;
  const SubTitle2(this.text, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}