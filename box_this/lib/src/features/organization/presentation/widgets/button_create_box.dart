import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class ButtonCreateBox extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonCreateBox({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 1.0, 
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
              width: 2.0, 
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
      ),
    );
  }
}
