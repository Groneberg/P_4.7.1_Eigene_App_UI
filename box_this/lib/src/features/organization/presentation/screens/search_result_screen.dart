import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/features/organization/presentation/widgets/accordion_list.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
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
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: TitleAppBar(
          title: "Results for '$query'",
          setBackIcon: true,
          icon: "search",
        ),
        body: Column(
          children: [
            CustomSearchBar(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                spacing: 3.5,
                children: [
                  Container(
                    width: 8,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: gradients?.greenGradient,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${getAmountOfFoundElements()} elements found",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  if (searchResults.boxes.isNotEmpty)
                    AccordionList(typ: "Box", box: searchResults, inBox: true),

                  if (searchResults.items.isNotEmpty)
                    AccordionList(typ: "Item", box: searchResults, inBox: true),

                  if (searchResults.events.isNotEmpty)
                    AccordionList(
                      typ: "Event",
                      box: searchResults,
                      inBox: true,
                    ),
                ],
              ),
            ),
            CustomBottemNavBar(),
          ],
        ),
      ),
    );
  }

  int getAmountOfFoundElements() {
    return searchResults.boxes.length +
        searchResults.items.length +
        searchResults.events.length;
  }
}
