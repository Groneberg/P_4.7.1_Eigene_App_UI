import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Box This',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(250, 250, 250, 1), // Alabaster
          secondary: Color.fromRGBO(223,185,131, 1.0), // Tumbleweed
          tertiary: Color.fromRGBO(58,72,1, 1.0), // Verdun Green
          onPrimary: Color.fromRGBO(78, 15, 25, 1.0), // Heath

          onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
          error: Color.fromRGBO(255, 12, 12, 1.0),
          onError: Color.fromRGBO(255, 255, 255, 1.0),
          surface: Color.fromRGBO(250, 250, 250, 1),
          onSurface: Color.fromRGBO(78, 15, 25, 1.0),
        ),
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          // statusBarColor: Color(0xFFFAFAFA),
          // statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: SafeArea(
          // child: HomeScreen()
          // child: BoxDetailScreen(),
          // child: CreateBoxScreen(),
          child: CreateItemScreen(),
        ),
      ),
    );
  }
}
