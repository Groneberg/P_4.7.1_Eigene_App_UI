import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: TiTleAppBar(
          title: "Home",
          setBackIcon: false,
        ),
        body : Center(
          child: Text(
            'Welcome to Box This!',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
