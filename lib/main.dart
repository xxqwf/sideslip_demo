import 'package:flutter/material.dart';

import 'pages/cover_appbar/cover_appbar_page.dart';
import 'pages/my_home.dart';
import 'pages/utils/bezier_move_pointer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'title'),
      // home: const BezierMovePointer(),
      // home: const CoverAppBarPage(),
    );
  }
}
