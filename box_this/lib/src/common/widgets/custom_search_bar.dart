import 'dart:developer';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:box_this/src/features/organization/presentation/screens/search_result_screen.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(BuildContext context, String query) async {
    if (query.isEmpty) {
      return; // Nicht suchen, wenn das Feld leer ist
    }

    final databaseRepository = Provider.of<SharedPreferencesRepository>(
      context,
      listen: false,
    );

    log("Searching for: $query");
    final Box searchResults = await databaseRepository.searchAllElements(query);

    if (!mounted) return;

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            SearchResultScreen(searchResults: searchResults, query: query),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

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
      ),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              // TODO Suche auch bei "Enter" auf der Tastatur auslösen / später weg
              onSubmitted: (value) {
                _performSearch(context, value);
              },
            ),
          ),
          Container(width: 5, color: const Color(0xFF000000)),
          IconButton(
            onPressed: () {
              _performSearch(context, _searchController.text);
            },
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
