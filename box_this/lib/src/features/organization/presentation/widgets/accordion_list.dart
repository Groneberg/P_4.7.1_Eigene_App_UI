import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/shared_preferences_repository.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccordionList extends StatefulWidget {
  final String typ;
  final Box box;

  const AccordionList({super.key, required this.typ, required this.box});

  @override
  State<AccordionList> createState() => _AccordionListState();
}

class _AccordionListState extends State<AccordionList> {
  bool _isExpanded = false;

  dynamic getElementMapByTyp(String typ) {
    switch (typ) {
      case "Box":
        return widget.box.boxes;
      case "Item":
        return widget.box.items;
      case "Event":
        return widget.box.events;
      default:
        return {};
    }
  }

  void deleteElementByTyp(String typ, String name) {
    SharedPreferencesRepository databaseRepository =
        Provider.of<SharedPreferencesRepository>(context, listen: false);

    switch (typ) {
      case "Box":
        databaseRepository.currentBox.boxes.remove(name);
        break;
      case "Item":
        databaseRepository.currentBox.items.remove(name);
        break;
      case "Event":
        databaseRepository.currentBox.events.remove(name);
        break;
      default:
        break;
    }
    databaseRepository.updateBox(Box(name: databaseRepository.currentBox.name, description: databaseRepository.currentBox.description, ), );
  }

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    dynamic elements = getElementMapByTyp(widget.typ);

    return Column(
      mainAxisSize: MainAxisSize.min,
      
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: gradients?.beigeGradient,
              border: Border.all(color: Theme.of(context).colorScheme.tertiary),
            ),
            child: Row(
              children: [
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    widget.typ,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          ListView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: elements.length,
            itemBuilder: (context, index) {
              String key = elements.keys.elementAt(index);
              var element = elements[key];
              return ListElement(
                element: element,
                onDelete: () {
                  deleteElementByTyp(widget.typ, key);
                  setState(() {});
                },
              );
            },
          ),
      ],
    );
  }
}