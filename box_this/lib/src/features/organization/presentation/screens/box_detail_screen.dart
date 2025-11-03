import 'dart:developer';

import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/provider/item_creation_provider.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_event_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_item_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/accordion_list.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_information.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxDetailScreen extends StatelessWidget {
  final Box box;

  const BoxDetailScreen({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    SharedPreferencesRepository databaseRepository =
        Provider.of<SharedPreferencesRepository>(context);

    databaseRepository.currentBox = box;
    final String title = databaseRepository.currentBox.name;
    final String description = databaseRepository.currentBox.description;
    log("Current Box Name: ${databaseRepository.currentBox.name}");
    log("Current Box: ${databaseRepository.currentBox}");

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: TiTleAppBar(title: title, setBackIcon: false, icon: "box_icon"),
        body: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElementInformation(description: description),
                  AccordionList(typ: "Box", box: box),
                  AccordionList(typ: "Item", box: box),
                  AccordionList(typ: "Event", box: box, inBox: true,),
                ],
              ),
            ),
            SizedBox(
              height: 88,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/box_icon.svg",
                    onPressed: () {
                      databaseRepository.currentBox = databaseRepository.mainBox
                          .findBoxById(box.id)!;
                      log("Current Box: ${databaseRepository.currentBox.name}");
                      navigatetoCreateBoxScreen(context);
                    },
                  ),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/item_icon.svg",
                    onPressed: () {
                      navigatetoCreateItemScreen(context);
                    },
                  ),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/event2_icon.svg",
                    onPressed: () {
                      navigatetoCreateEventScreen(context);
                    },
                  ),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/edit_icon.svg",
                    onPressed: () {
                      navigateToEditBoxScreen(box, context);
                    },
                  ),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/delete_icon.svg",
                    onPressed: () {
                      Navigator.pop(context);
                      databaseRepository.deleteBox(box.id);
                    },
                  ),
                ],
              ),
            ),
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
      // MaterialPageRoute(
      //   builder: (context) => CreateBoxScreen(),
      // ),
    );
  }

  void navigatetoCreateItemScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChangeNotifierProvider(
            create: (context) => ItemCreationProvider(),
            child: CreateItemScreen(),
          ),


        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(
      //   builder: (context) => HomeScreen(),
      // ),
    );
  }

  void navigateToEditBoxScreen(Box box, BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditBoxScreen(box: box),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // // TODO navigation anpassen für Item und Event
      // MaterialPageRoute(builder: (context) => BoxDetailScreen(box: widget.element)),
    );
  }

  void navigatetoCreateEventScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CreateEventScreen(fromBoxDetailScreen: true,),
      ),
      // MaterialPageRoute(
      //   builder: (context) => CreateEventScreen(),
      // ),
    );
  }
}
