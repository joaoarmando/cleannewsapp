import 'package:flutter/material.dart';

import 'subtitle1.dart';
import 'subtitle2.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, size: 80, color: Colors.black.withOpacity(.2)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: SubTitle1("Algo deu errado 😞"),
          ),
          const SubTitle2("Não foi possível concluir sua solicitação, tente novamente mais tarde.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}