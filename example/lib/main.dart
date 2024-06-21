import 'package:example/new/new_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: ColoredBox(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(84.0),
            child: MyContainerStage(),
          ),
        ),
      ),
    ),
  );
}
