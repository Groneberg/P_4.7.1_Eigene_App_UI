import 'dart:developer';

import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_event_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/create_item_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_box_screen.dart';
import 'package:box_this/src/features/organization/presentation/screens/edit_item_screen.dart';
import 'package:box_this/src/features/organization/presentation/widgets/accordion_list.dart';
import 'package:box_this/src/features/organization/presentation/widgets/element_information.dart';
import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatefulWidget {
  final Item item;

  const ItemDetailScreen({super.key, required this.item});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    SharedPreferencesRepository databaseRepository =
        Provider.of<SharedPreferencesRepository>(context);

    // Box? foundBox = databaseRepository.mainBox.findBoxByName(box.name);
    // if (foundBox == null) {
    //   return Scaffold(
    //     backgroundColor: Colors.transparent,
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // databaseRepository.currentBox = databaseRepository.mainBox.findBoxByName(
    //   box.name,
    // )!;

    final String name = widget.item.name;

    final String description = widget.item.description;
    final String location = widget.item.location;
    log("Current Box: ${databaseRepository.currentBox.name}");

    TextEditingController _amountController = TextEditingController(
      text: databaseRepository.currentBox.items[name]!.amount.toString(),
      // text: widget.item.amount.toString(),
    );
    TextEditingController _minAmountController = TextEditingController(
      text: databaseRepository.currentBox.items[name]!.minAmount.toString(),
      // text: widget.item.minAmount.toString(),
    );

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: TiTleAppBar(title: name, setBackIcon: false, icon: "item_icon"),
        body: Column(
          children: [
            CustomSearchBar(),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElementInformation(description: description),
                  ElementInformation(location: location),
                  // TODO optisch anpassen
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LabelName(labelName: "Amount", labelWidth: 80),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: TextFormField(
                                controller: _amountController,
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            int currentAmount =
                                int.tryParse(_amountController.text) ?? 0;
                            int currentMinAmount =
                                int.tryParse(_minAmountController.text) ?? 0;
                            currentAmount++;
                            _amountController.text = currentAmount.toString();
                            context
                                .read<SharedPreferencesRepository>()
                                .updateItemAmount(
                                  widget.item.name,
                                  currentAmount,
                                  currentMinAmount,
                                );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            int currentAmount =
                                int.tryParse(_amountController.text) ?? 0;
                            int currentMinAmount =
                                int.tryParse(_minAmountController.text) ?? 0;
                            currentAmount--;
                            _amountController.text = currentAmount.toString();
                            context
                                .read<SharedPreferencesRepository>()
                                .updateItemAmount(
                                  widget.item.name,
                                  currentAmount,
                                  currentMinAmount,
                                );
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // TODO optisch anpassen
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LabelName(labelName: "MinAmount", labelWidth: 80),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: TextFormField(
                                controller: _minAmountController,
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyLarge,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            int currentAmount =
                                int.tryParse(_amountController.text) ?? 0;
                            int currentMinAmount =
                                int.tryParse(_minAmountController.text) ?? 0;
                            currentMinAmount++;
                            _amountController.text = currentAmount.toString();
                            context
                                .read<SharedPreferencesRepository>()
                                .updateItemAmount(
                                  widget.item.name,
                                  currentAmount,
                                  currentMinAmount,
                                );
                          },
                          icon: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            int currentAmount =
                                int.tryParse(_amountController.text) ?? 0;
                            int currentMinAmount =
                                int.tryParse(_minAmountController.text) ?? 0;
                            currentMinAmount--;
                            _amountController.text = currentAmount.toString();
                            context
                                .read<SharedPreferencesRepository>()
                                .updateItemAmount(
                                  widget.item.name,
                                  currentAmount,
                                  currentMinAmount,
                                );
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  AccordionList(
                    typ: "EventInItem",
                    box: databaseRepository.currentBox,
                    inBox: false,
                    itemName: widget.item.name,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 88,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 40),
                  SizedBox(width: 40),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/event2_icon.svg",
                    onPressed: () {
                      navigatetoCreateEventScreen(
                        context,
                        widget.item,
                        true,
                        false,
                      );
                    },
                  ),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/edit_icon.svg",
                    onPressed: () {
                      navigateToEditItemScreen(widget.item, context);
                    },
                  ),
                  SmallActionButton(
                    svgIconPath: "assets/svg/icons/delete_icon.svg",
                    onPressed: () {
                      Navigator.pop(context);
                      databaseRepository.deleteItem(widget.item.name);
                    },
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

  void navigatetoCreateBoxScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CreateBoxScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(
      //   builder: (context) => CreateBoxScreen(),
      // ),
    );
  }

  void navigateToEditItemScreen(Item item, BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditItemScreen(item: item),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // // TODO navigation anpassen für Item und Event
      // MaterialPageRoute(builder: (context) => ItemDetailScreen(box: widget.element)),
    );
  }

  void navigatetoCreateEventScreen(
    BuildContext context,
    Item item,
    bool fromItemDetailScreen,
    bool fromCreateItemScreen,
  ) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            CreateEventScreen(
              item: item,
              fromBoxDetailScreen: false,
              fromItemDetailScreen: true,
              fromCreateItemScreen: false,
            ),
      ),
      // MaterialPageRoute(
      //   builder: (context) => CreateEventScreen(),
      // ),
    );
  }
}
