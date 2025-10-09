import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/features/organization/presentation/widgets/amount_input.dart';
import 'package:box_this/src/features/organization/presentation/widgets/create_button.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_name_input.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_text_input.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:flutter/material.dart';

class CreateItemScreen extends StatelessWidget {
  const CreateItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(
        title: "Create Item",
        setBackIcon: false,
        icon: "item_icon",
      ),
      body: Column(
        children: [
          CustomSearchBar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, right: 24,left: 24.0),
              child: Column(
                spacing: 24,
                children: [
                  // ElementNameInput(icon: "item_icon", hintText: "Itemname...",),
                  ElementTextInput(labelName: "Description", hintText: "Description..."),
                  ElementTextInput(labelName: "Location", hintText: "Location..."),
                  AmountInput(labelName: "Amount"),
                  AmountInput(labelName: "MinAmount"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallActionButton(
                        svgIconPath: "assets/svg/icons/event2_icon.svg",
                        onPressed: () {
                          
                        },
                      ),
                    ],
                  )
                ],
              )
            ),
          ),

          CreateButton(),
          CustomBottemNavBar(),
        ],
      ),
    );
  }
}
