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
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [const Color(0xFF3A4801), const Color(0xFF7D9200)],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4E0F19),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "less",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    // TODO dezente Farbe
                    color: Color(0xFF4E0F19),
                  ),
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
                      color: Color(0xFF3A4801),
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontFamily: "ROboto",
                    fontSize: 16,
                    color: Color(0xFF4E0F19),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
