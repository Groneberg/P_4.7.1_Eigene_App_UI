import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/features/organization/presentation/widgets/accordion_list.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_description.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:box_this/src/features/organization/presentation/widgets/user_prompt_alert_dialog.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class BuildWidgetScreen extends StatefulWidget {
  const BuildWidgetScreen({super.key});

  @override
  State<BuildWidgetScreen> createState() => _BuildWidgetScreenState();
}

class _BuildWidgetScreenState extends State<BuildWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(title: "Home", setBackIcon: false, icon: "home_icon"),
      body: ElementDescription(
        description:
            "Dies ist eine Beschreibung eines Elements. Hier können Details angezeigt werden.",
      ),  
    );
  }
}
