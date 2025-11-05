import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/features/organization/presentation/widgets/accordion_list.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final Box searchResults;
  final String query;

  const SearchResultScreen({
    super.key,
    required this.searchResults,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    // Da die searchResults-Box (searchResults.boxes, searchResults.items, etc.)
    // die gefundenen Elemente enthält, können wir sie direkt an AccordionList übergeben.
    
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: TitleAppBar(
          title: "Results for '$query'", // Zeigt den Suchbegriff im Titel an
          setBackIcon: true, // Erlaubt dem Benutzer zurückzugehen
          icon: "search", // oder ein passendes Icon
        ),
        body: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: ListView( // ListView, falls die Listen lang werden
                children: [
                  // Zeigt die gefundenen Boxen an
                  AccordionList(
                    typ: "Box",
                    box: searchResults, // Übergibt die Box mit den Suchergebnissen
                    inBox: true, // Ggf. anpassen, je nach Ihrer AccordionList-Logik
                  ),
                  // Zeigt die gefundenen Items an
                  AccordionList(
                    typ: "Item",
                    box: searchResults,
                    inBox: true,
                  ),
                  // Zeigt die gefundenen Events an
                  AccordionList(
                    typ: "Event",
                    box: searchResults,
                    inBox: true,
                  ),
                ],
              ),
            ),
            CustomBottemNavBar(), // Ihre Standard-Navigationsleiste
          ],
        ),
      ),
    );
  }
}