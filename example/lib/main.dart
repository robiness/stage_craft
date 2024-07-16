import 'package:example/my_awesome_widget_stage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyAwesomeWidgetStage(),
      ),
    ),
  );
}
