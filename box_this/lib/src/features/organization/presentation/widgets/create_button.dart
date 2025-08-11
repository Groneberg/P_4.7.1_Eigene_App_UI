import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: gradients?.greenGradient,
        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Center(
        child: Text(
          "Creat",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
