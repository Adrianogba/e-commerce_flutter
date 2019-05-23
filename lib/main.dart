import 'package:flutter/material.dart';

import 'ui/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'FruitFair',
        theme: ThemeData(

          primarySwatch: Colors.deepOrange,
        ),
        home: Menu());
  }
}
