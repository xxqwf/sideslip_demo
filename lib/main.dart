import 'package:flutter/material.dart';
import 'package:sideslip_demo/pages/my_home.dart';
import 'pages/sideslip/sideslip_animation_widget.dart';

import 'pages/cover_appbar/cover_appbar_page.dart';
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
      home: const MyHomeWidget(),
      // home: const BezierMovePointer(),
      // home: const CoverAppBarPage(),
    );
  }
}
