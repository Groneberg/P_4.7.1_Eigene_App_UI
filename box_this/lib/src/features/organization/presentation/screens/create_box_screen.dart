import 'dart:developer';

import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/home_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';

import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CreateBoxScreen extends StatefulWidget {

  CreateBoxScreen({super.key});

  @override
  State<CreateBoxScreen> createState() => _CreateBoxScreenState();
}

class _CreateBoxScreenState extends State<CreateBoxScreen> {
  // final MockDatabaseRepository repository = MockDatabaseRepository();
  final TextEditingController boxNameController = TextEditingController();

  final TextEditingController boxDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    boxNameController.dispose();
    boxDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return SafeArea(
      top: true,
      bottom: true,

      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: TiTleAppBar(
          title: "Create Box",
          setBackIcon: false,
          icon: "box_icon",
        ),
        body: Center(
          child: Column(
            children: [
              CustomSearchBar(),
              // BoxDataInput(
              //   boxTextEditingController: boxTextEditingController,
              // ), // Expanded
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ElementNameInput(icon: "box_icon", hintText: "Boxname...", boxTextEditingController: boxTextEditingController,),
                      Row(
                        children: [
                          SizedBox(
                            width: 48,
                            // padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/icons/box_icon.svg",
                                  height: 34,
                                  width: 30,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onPrimary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              child: TextFormField(
                                controller: boxNameController,
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: "Boxname...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // ElementTextInput(
                      //   labelName: "Description",
                      //   hintText: "Description...",
                      // ),
                      Column(
                        children: [
                          LabelName(labelName: "Description", labelWidth: 200),
                          SizedBox(height: 8),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 8,
                              ),
                              child: TextFormField(
                                controller: boxDescriptionController,
                                maxLines: null,
                                minLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: Theme.of(context).textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: "Description...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // TODO neu bauen mit button widget ?
              // CreateButton(),
              Consumer<SharedPreferencesRepository>(
                builder: (context, databaseRepository, child) =>
                    GestureDetector(
                      onTap: () {
                        createBox(context);
                      },
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: gradients?.greenGradient,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Creat",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                    ),
              ),
              CustomBottemNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  void createBox(BuildContext context) {
    final databaseRepository = Provider.of<SharedPreferencesRepository>(
      context,
      listen: false,
    );
    log("mainBox before creating new box: ${databaseRepository.mainBox}");
    databaseRepository.createBox(
      Box(
        name: boxNameController.text,
        description: boxDescriptionController.text,
        parentId: databaseRepository.currentBox.id,
      ),
    );
    log("Current Boxes: ${databaseRepository.currentBox.boxes}");
    Navigator.pop(context);
  }

  // TODO später Navigation anpassen
  void navigatetoHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(
      //   builder: (context) => HomeScreen(),
      // ),
    );
  }
}
