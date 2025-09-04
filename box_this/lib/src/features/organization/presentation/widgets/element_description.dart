import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class ElementDescription extends StatefulWidget {
  final String description;
  final bool isExtended;

  const ElementDescription({
    super.key,
    this.description = "",
    this.isExtended = true,
  });

  @override
  State<ElementDescription> createState() => _ElementDescriptionState();
}

class _ElementDescriptionState extends State<ElementDescription> {

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),

      child: Column(
        spacing: 8,
        children: [
          Row(
            spacing: 3.5,
            children: [
              Container(
                width: 8,
                height: 20,
                decoration: BoxDecoration(
                  gradient: gradients?.greenGradient
                ),
              ),
              Expanded(
                child: Text(
                  "Description",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: Text(
                  "less",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.tertiary,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
