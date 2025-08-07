import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListElement extends StatefulWidget {
  // Box box;
  // Item item;
  // Event event;
  const ListElement({super.key});

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF3A4801),
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
                "assets/svg/icons/box_icon.svg",
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
                child: Text(
                  "Garden",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4E0F19),
                  ),
                ),
              ),
              SizedBox(
                width: 72,
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.edit, color: const Color(0xFF4E0F19), size: 24),
                    // SizedBox(width: 16,),
                    Icon(
                      Icons.delete,
                      color: const Color(0xFF4E0F19),
                      size: 24,
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4E0F19),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  //
                  "0",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4E0F19),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  "Events",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4E0F19),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  "0",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4E0F19),
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
