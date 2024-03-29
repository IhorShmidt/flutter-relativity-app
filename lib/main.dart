import 'package:flutter/material.dart';
import 'package:flutter_relativity/screens/relativity_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Relativity',
        debugShowCheckedModeBanner: false,
        home: RelativityScreen()
    );
  }
}
