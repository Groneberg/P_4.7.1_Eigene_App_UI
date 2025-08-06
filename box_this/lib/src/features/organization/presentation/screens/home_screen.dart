import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/features/organization/presentation/widgets/button_create_box.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(title: "Home", setBackIcon: false, icon: "home_icon"),
      body: Column(
        children: [
          CustomSearchBar(),
          ListElement(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [ButtonCreateBox()],
            ),
          ),
          SizedBox(height: 90),
          CustomBottemNavBar(),
          // SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
