import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/button_create_box.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: TitleAppBar(
          title: "Home",
          setBackIcon: false,
          icon: "home_icon",
        ),
        body: Column(
          children: [
            CustomSearchBar(),

            Consumer<SharedPreferencesRepository>(
              builder: (context, databaseRepository, child) {
                final boxes = databaseRepository.mainBox.boxes;

                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: boxes.length,
                          itemBuilder: (context, index) {
                            String key = boxes.keys.elementAt(index);
                            final box = boxes[key]!;

                            return ListElement(
                              element: box,
                              onDelete: () {
                                databaseRepository.deleteBox(key);
                              },
                            );
                          },
                        ),
                      ),

                      ButtonCreateBox(
                        onPressed: () {
                          databaseRepository.currentBox =
                              databaseRepository.mainBox;
                          navigatetoCreateBoxScreen(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            SizedBox(height: 24),
            CustomBottemNavBar(),
          ],
        ),
      ),
    );
  }

  void navigatetoCreateBoxScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CreateBoxScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
