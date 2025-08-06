import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [const Color(0xFFF1D5AE), const Color(0xFFDBB77F), const Color(0xFFDFB983)],
          stops: [0.0, 0.5564, 1.0],
        ),
        border: Border.all(
          color: const Color(0xFF3A4801),
          width: 1.0, // 1px
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: const Color(0xFFFAFAFA),
        //     offset: Offset(0, 0),
        //     blurRadius: 10.0,
        //     spreadRadius: 0.0,
        //   ),
        // ],
      ),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            // TODO wert aus TextField speichern
            child: TextField(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(width: 5, color: const Color(0xFF000000)),
          Icon(Icons.search, color: const Color(0xFF4E0F19), size: 24),
        ],
      ),
    );
  }
}
