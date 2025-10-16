import 'dart:developer';

import 'package:box_this/src/common/widgets/custom_bottem_nav_bar.dart';
import 'package:box_this/src/common/widgets/custom_search_bar.dart';
import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/item.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/screens/box_detail_screen.dart';
// import 'package:box_this/src/features/organization/presentation/widgets/amount_input.dart';
// import 'package:box_this/src/features/organization/presentation/widgets/element_text_input.dart';
import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';
import 'package:box_this/src/features/organization/presentation/widgets/small_action_button.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  final Item? item;
  const EditItemScreen({super.key, this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _minAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    if (item != null) {
      _itemNameController.text = item.name;
      _descriptionController.text = item.description;
      _locationController.text = item.location ?? "";
      _amountController.text = item.amount.toString();
      _minAmountController.text = item.minAmount.toString();
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _amountController.dispose();
    _minAmountController.dispose();
    super.dispose();
  }

  void updateItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final databaseRepository = Provider.of<SharedPreferencesRepository>(
        context,
        listen: false,
      );

      log("Creating Item: ${_itemNameController.text}");
      databaseRepository.updateItem(
        Item(
          name: _itemNameController.text,
          description: _descriptionController.text,
          amount: _amountController.text.isEmpty
              ? 0
              : int.parse(_amountController.text),
          minAmount: _minAmountController.text.isEmpty
              ? 0
              : int.parse(_minAmountController.text),
          location: _locationController.text,
        ),
      );
      navigatetoBoxDetailScreen(context);
    } else {
      // TODO bessere Fehlerbehandlung
      log("Form is not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(
        title: "Edit Item",
        setBackIcon: false,
        icon: "item_icon",
      ),
      body: Column(
        children: [
          CustomSearchBar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, right: 24, left: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 24,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 48,
                          // padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/icons/item_icon.svg",
                                height: 34,
                                width: 30,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onPrimary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            child: TextFormField(
                              controller: _itemNameController,
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.bodyLarge,
                              decoration: InputDecoration(
                                hintText: "Itemname...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ElementNameInput(icon: "item_icon", hintText: "Itemname...",),
                    // ElementTextInput(labelName: "Description",hintText: "Description...",),
                    Column(
                      children: [
                        LabelName(labelName: "Description", labelWidth: 200),
                        SizedBox(height: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8,
                            ),
                            child: TextFormField(
                              controller: _descriptionController,
                              maxLines: null,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Theme.of(context).textTheme.bodyLarge,
                              decoration: InputDecoration(
                                hintText: "Description...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ElementTextInput(
                    //   labelName: "Location",
                    //   hintText: "Location...",
                    // ),
                    Column(
                      children: [
                        LabelName(labelName: "Location", labelWidth: 200),
                        SizedBox(height: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 8,
                            ),
                            child: TextFormField(
                              controller: _locationController,
                              maxLines: null,
                              minLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: Theme.of(context).textTheme.bodyLarge,
                              decoration: InputDecoration(
                                hintText: "Location...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                            setState(() {
                              int currentAmount = int.tryParse(_amountController.text) ?? 0;
                              currentAmount++;
                              _amountController.text = currentAmount.toString();
                            });
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
                            setState(() {
                              int currentAmount = int.tryParse(_amountController.text) ?? 0;
                              if (currentAmount > 0) {
                                currentAmount--;
                                _amountController.text = currentAmount.toString();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                            setState(() {
                              int currentAmount = int.tryParse(_minAmountController.text) ?? 0;
                              currentAmount++;
                              _minAmountController.text = currentAmount.toString();
                            });
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
                            setState(() {
                              int currentAmount = int.tryParse(_minAmountController.text) ?? 0;
                              if (currentAmount > 0) {
                                currentAmount--;
                                _minAmountController.text = currentAmount.toString();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SmallActionButton(
                          svgIconPath: "assets/svg/icons/event2_icon.svg",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // CreateButton(),
          Consumer<SharedPreferencesRepository>(
            builder: (context, databaseRepository, child) => GestureDetector(
              onTap: () {
                updateItem(context);
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: gradients?.greenGradient,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Edit",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ),
          CustomBottemNavBar(),
        ],
      ),
    );
  }

    void navigatetoBoxDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => BoxDetailScreen(box: SharedPreferencesRepository.instance.currentBox),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(
      //   builder: (context) => CreateBoxScreen(),
      // ),
    );
  }

}
