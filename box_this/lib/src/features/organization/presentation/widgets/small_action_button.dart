import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmallActionButton extends StatelessWidget {
  final String svgIconPath;
  const SmallActionButton({
    super.key, required this.svgIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFFF1D5AE),
            const Color(0xFFDBB77F),
            const Color(0xFFDFB983),
          ],
          stops: [0.0, 0.5564, 1.0],
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 2.0,
        ),
      ),
      child: Center( child: 
        SvgPicture.asset(
          svgIconPath,
          colorFilter: ColorFilter.mode(
            const Color(0xFF4E0F19),
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
