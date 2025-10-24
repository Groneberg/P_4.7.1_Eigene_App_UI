import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/event.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_event_screen%20copy.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_item_screen.dart';
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

  String getFirstLabelByTyp(String typ) {
    switch (typ) {
      case "box":
        return "Items";
      case "item":
        return "Amount";
      case "event":
        return "Date";
      default:
        return "";
    }
  }

  String getFirstValueByTyp(String typ) {
    switch (typ) {
      case "box":
        return widget.element.items.length.toString();
      case "item":
        return widget.element.amount.toString();
      case "event":
        return widget.element.date.toString();
      default:
        return "";
    }
  }

  String getSecondLabelByTyp(String typ) {
    switch (typ) {
      case "box":
        return "Events";
      case "item":
        return "Min. Amount";
      case "event":
        return "Time";
      default:
        return "";
    }
  }

  String getSecondValueByTyp(String typ) {
    switch (typ) {
      case "box":
        return widget.element.events.length.toString();
      case "item":
        return widget.element.minAmount.toString();
      case "event":
        return widget.element.time.toString();
      default:
        return "";
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
                        navigateToEditScreen(context);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 24,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // SharedPreferencesRepository.instance.deleteBox(
                        //   widget.element.name,
                        // );
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
                width: 70,
                child: Text(
                  getFirstLabelByTyp(getElementTyp()),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  getFirstValueByTyp(getElementTyp()),
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  getSecondLabelByTyp(getElementTyp()),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  getSecondValueByTyp(getElementTyp()),
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
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            BoxDetailScreen(box: widget.element),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // // TODO navigation anpassen für Item und Event
      // MaterialPageRoute(builder: (context) => BoxDetailScreen(box: widget.element)),
    );
  }

  void navigateToEditScreen(BuildContext context) {
    var editScreen;
    switch (getElementTyp()) {
      case "box":
        editScreen = EditBoxScreen(box: widget.element);
        break;
      case "item":
        editScreen = EditItemScreen(item: widget.element,);
        break;
      case "event":
        editScreen = EditEventScreen();
        break;
      default:
        editScreen = null;
    }
    
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            editScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(builder: (context) => BoxDetailScreen(box: widget.element)),
    );
  }
}
