import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListElement extends StatefulWidget {
  final dynamic element;
  final VoidCallback onDelete;
  const ListElement({super.key, required this.element, required this.onDelete});

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {

  String getElementTyp() {
    if (widget.element is Box) {
      return "box";
    } else if (widget.element is Item) {
      return "item";
    } else if (widget.element is Event) {
      return "event";
    } else {
      return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0, // 1px
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              // Icon(
              //   Icons.check_box_outline_blank,
              //   color: const Color(0xFF4E0F19),
              //   size: 32,
              // ),
              // TODO Variable für svg
              SvgPicture.asset(
                "assets/svg/icons/${getElementTyp()}_icon.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
                width: 32,
                height: 32,
              ),
              SizedBox(width: 16),
              // widget.box.name
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    navigateToBoxDetailScreen(context);
                  },
                  child: Text(
                    widget.element.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              SizedBox(
                width: 72,
                child: Row(
                  spacing: 24,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO später Navigation zu Edit Screen
                      },
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 24,
                      ),
                    ),
                    // SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () {
                        MockDatabaseRepository.instance.deleteBox(
                          widget.element.name,
                        );
                        widget.onDelete();
                      },
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 60,
                child: Text(
                  "Items",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  //
                  widget.element.items.length.toString(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  "Events",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  widget.element.events.length.toString(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO später Navigation anpassen / EditBoxScreen bauen
  // void navigateToEditBoxScreen(BuildContext context) {
  //   Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => EditBoxScreen(),
  //   ),
  // );

  void navigateToBoxDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      // TODO navigation anpassen für Item und Event
      MaterialPageRoute(builder: (context) => BoxDetailScreen(box: widget.element)),
    );
  }
}
