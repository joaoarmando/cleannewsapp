import 'package:flutter/material.dart';

class SubTitle1 extends StatelessWidget {
  final String text;
  const SubTitle1(this.text, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}