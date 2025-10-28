import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class ElementInformation extends StatefulWidget {
  final String description;
  final String location;
  final bool isExtended;

  const ElementInformation({
    super.key,
    this.description = "",
    this.location = "",
    this.isExtended = true,
  });

  @override
  State<ElementInformation> createState() => _ElementDescriptionState();
}

class _ElementDescriptionState extends State<ElementInformation> {
  bool _isExtended = true;
  String information = "";
  String title = "";

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    if (widget.description.isEmpty && widget.location.isNotEmpty) {
      title = "Location";
      information = widget.location;
    } else if (widget.location.isEmpty && widget.description.isNotEmpty) {
      title = "Description";
      information = widget.description;
    } 

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
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExtended = !_isExtended;
                    });
                  },
                  child: Text(
                    _isExtended ? "less" : "more",
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
          if (_isExtended)
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
                  
                  information,
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
