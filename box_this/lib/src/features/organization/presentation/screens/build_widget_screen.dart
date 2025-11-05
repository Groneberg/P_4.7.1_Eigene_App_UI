import 'dart:ffi';

import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_information.dart';
import 'package:box_this/src/features/organization/presentation/widgets/themed_time_picker.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildWidgetScreen extends StatefulWidget {
  const BuildWidgetScreen({super.key});

  @override
  State<BuildWidgetScreen> createState() => _BuildWidgetScreenState();
}

class _BuildWidgetScreenState extends State<BuildWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: TitleAppBar(title: "Home", setBackIcon: false, icon: "home_icon"),
        body: Column(
          children: [
            // ThemedTimePicker()
            ThemedDatePicker(),
          ],
        ),
      ),
    );
  }
}

class ThemedDatePicker extends StatelessWidget {
  const ThemedDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Selected date: ${picked.toLocal()}')),
          );
        }
      },
      child: const Text('Pick a date'),
    );
  }
}
