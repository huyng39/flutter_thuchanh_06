import 'package:flutter/material.dart';
import 'package:flutter_thuchanh_06/mainpage.dart';
import 'package:flutter_thuchanh_06/page/homewidget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainpage(),
    );
  }
}
