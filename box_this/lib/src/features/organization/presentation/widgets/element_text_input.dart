import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';
import 'package:flutter/material.dart';

class ElementTextInput extends StatelessWidget {
  final String labelName;
  final String hintText;

  const ElementTextInput({
    super.key, required this.labelName, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelName(labelName: labelName, labelWidth: 200,),
        SizedBox(height: 8,),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: null,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
