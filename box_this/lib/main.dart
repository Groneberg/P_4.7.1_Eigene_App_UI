import 'dart:developer';

import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/build_widget_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_item_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/home_screen.dart';
import 'package:box_this/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final MockDatabaseRepository repository = MockDatabaseRepository();
  // final SharedPreferencesRepository repository =
  //     SharedPreferencesRepository.instance;
  // await repository.initializePersistence();


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Box This',
      theme: AppTheme.lightTheme,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        child: SafeArea(
          // child: HomeScreen(),
          // child: CreateBoxScreen(),
          // child: BoxDetailScreen(),
          // child: CreateItemScreen(),
          child: BuildWidgetScreen(),
        ),
      ),
    );
  }
}
