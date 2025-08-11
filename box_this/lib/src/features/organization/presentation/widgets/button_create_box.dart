import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class ButtonCreateBox extends StatefulWidget {
  const ButtonCreateBox({super.key});

  @override
  State<ButtonCreateBox> createState() => _ButtonCreateBoxState();
}

class _ButtonCreateBoxState extends State<ButtonCreateBox> {
  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0, // 1px
        ),
        gradient: gradients?.beigeGradient,
      ),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.tertiary,
              width: 2.0, // 1px
            ),
            gradient: gradients?.beigeGradient,
          ),
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 36,
          ),
        ),
      ),
    );
  }
}
