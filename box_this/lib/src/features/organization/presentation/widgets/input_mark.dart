import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class InputMark extends StatelessWidget {
  const InputMark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();
    return Container(
      width: 8,
      height: 20,
      decoration: BoxDecoration(
        gradient: gradients?.greenGradient,
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
