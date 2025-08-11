import 'package:box_this/src/features/organization/presentation/widgets/input_mark.dart';
import 'package:flutter/material.dart';

class LabelName extends StatelessWidget {
  const LabelName({
    super.key,
    required this.labelName, required this.labelWidth,
  });

  final String labelName;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 3.5,
      children: [
        InputMark(),
        SizedBox(
          width: labelWidth,
          height: 20,
          child: Text(
            labelName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
