import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ElementNameInput extends StatelessWidget {
  final String icon;
  final String hintText;
  final TextEditingController boxTextEditingController;

  const ElementNameInput({
    super.key,
    required this.icon,
    required this.hintText,
    required this.boxTextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          // padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/icons/$icon.svg",
                height: 34,
                width: 30,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.tertiary),
            ),
            child: TextFormField(
              controller: boxTextEditingController,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge,
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
