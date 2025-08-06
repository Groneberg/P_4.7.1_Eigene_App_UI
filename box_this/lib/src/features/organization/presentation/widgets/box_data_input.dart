import 'package:box_this/src/features/organization/presentation/widgets/element_name_input.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_text_input.dart';
import 'package:flutter/material.dart';

class BoxDataInput extends StatelessWidget {
  const BoxDataInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElementNameInput(icon: "box_icon", hintText: "Boxname...",),
            ElementTextInput(labelName: "Description", hintText: "Description...",),
          ],
        ),
      ),
    );
  }
}
