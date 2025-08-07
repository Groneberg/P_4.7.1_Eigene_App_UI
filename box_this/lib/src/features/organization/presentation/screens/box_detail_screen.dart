import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_description.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:flutter/material.dart';

class BoxDetailScreen extends StatelessWidget {
  const BoxDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO aus Theme
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: TiTleAppBar(title: "Garden", setBackIcon: false, icon: "box_icon"),
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElementDescription(
                  description:
                      "A garden is a delimited outdoor space that is primarily created and used for cultivating plants.",
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
