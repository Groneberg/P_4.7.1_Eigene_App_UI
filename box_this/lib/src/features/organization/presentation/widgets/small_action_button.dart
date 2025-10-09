import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmallActionButton extends StatelessWidget {
  final String svgIconPath;
  final VoidCallback onPressed;
  
  const SmallActionButton({super.key, required this.svgIconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          gradient: gradients?.beigeGradient,
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 2.0,
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgIconPath,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
