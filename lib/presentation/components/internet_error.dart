import 'package:flutter/material.dart';

import 'subtitle1.dart';
import 'subtitle2.dart';

class InternetError extends StatelessWidget {
  final VoidCallback? retry;
  const InternetError({ Key? key, this.retry }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off, size: 80, color: Colors.black.withOpacity(.2)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: SubTitle1("Sem conexão com a internet"),
          ),
          const SubTitle2("Verifique sua conexão com a internet e tente novamente mais tarde",
            textAlign: TextAlign.center,
          ),
          retry != null ? TextButton(
            key: const Key("retry_button"),
            onPressed: retry, 
            child: const Text("Tentar novamente")
          ) : const SizedBox()
        ],
      ),
    );
  }
}