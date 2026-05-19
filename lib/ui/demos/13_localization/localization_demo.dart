import 'package:flutter/material.dart';
import 'package:flutter_demo/l10n/app_localization.dart';

class LocalizationDemo extends StatefulWidget {
  const LocalizationDemo({super.key});

  @override
  State<LocalizationDemo> createState() => _LocalizationDemoState();
}

class _LocalizationDemoState extends State<LocalizationDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text( 
          AppLocalizations.of(context)!.helloWord, 
          style: TextStyle(fontSize: 30)),

        )
    );
  }
}