import 'dart:developer';

import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_description.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:flutter/material.dart';

class BoxDetailScreen extends StatelessWidget {
  final Box box;

  const BoxDetailScreen({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    // final MockDatabaseRepository repository = MockDatabaseRepository();
    // TODO vielleicht später probleme
    MockDatabaseRepository.instance.currentBox = MockDatabaseRepository.instance.mainBox.findBoxByName(box.name)!;
    final String title = MockDatabaseRepository.instance.currentBox.name;
    final String description = MockDatabaseRepository.instance.currentBox.description;
    log("Current Box: ${MockDatabaseRepository.instance.currentBox.name}");

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: TiTleAppBar(title: title, setBackIcon: false, icon: "box_icon"),
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElementDescription(
                  description:
                      description,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 88,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmallActionButton(svgIconPath: "assets/svg/icons/box_icon.svg"),
                SmallActionButton(
                  svgIconPath: "assets/svg/icons/item_icon.svg",
                ),
                SmallActionButton(
                  svgIconPath: "assets/svg/icons/event2_icon.svg",
                ),
                SmallActionButton(
                  svgIconPath: "assets/svg/icons/edit_icon.svg",
                ),
                SmallActionButton(
                  svgIconPath: "assets/svg/icons/delete_icon.svg",
                ),
              ],
            ),
          ),
          CustomBottemNavBar(),
        ],
      ),
    );
  }
}
