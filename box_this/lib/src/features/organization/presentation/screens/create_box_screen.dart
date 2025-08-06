import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/features/organization/presentation/widgets/box_data_input.dart';
import 'package:box_this/src/features/organization/presentation/widgets/create_button.dart';
import 'package:flutter/material.dart';

class CreateBoxScreen extends StatelessWidget {
  const CreateBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(title: "Create Box", setBackIcon: false, icon: "box_icon",),
      body: Column(
        children: [
          CustomSearchBar(),
          BoxDataInput(), // Expanded
          CreateButton(),
          CustomBottemNavBar(),
        ],
      ),
    );
  }
}
