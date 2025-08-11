import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();
    
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        gradient: gradients?.beigeGradient,
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
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
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(width: 5, color: const Color(0xFF000000)),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
