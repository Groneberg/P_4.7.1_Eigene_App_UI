import 'package:box_this/src/common/widgets/title_app_bar.dart';
import 'package:box_this/src/data/model/box.dart';
import 'package:box_this/src/data/repositories/mock_database_repository.dart';
import 'package:box_this/src/features/organization/presentation/widgets/list_element.dart';
import 'package:box_this/src/features/organization/presentation/widgets/user_prompt_alert_dialog.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class BuildWidgetScreen extends StatefulWidget {
  const BuildWidgetScreen({super.key});

  @override
  State<BuildWidgetScreen> createState() => _BuildWidgetScreenState();
}

class _BuildWidgetScreenState extends State<BuildWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: TiTleAppBar(title: "Home", setBackIcon: false, icon: "home_icon"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            // child: UserPromptAlertDialog(promptText: "Delete Box?")
            child: AccordionList(
              typ: "Box",
              box: MockDatabaseRepository.instance.currentBox,
              
            )
          ),
        ],
      ),
    );
  }
}

class AccordionList extends StatelessWidget {
  final String typ;
  final Box box; 
  const AccordionList({super.key, required this.typ, required this.box});

  dynamic getElementMapByTyp(String typ) {
    switch (typ) {
      case "Box":
        return box.boxes;
      case "Item":
        return box.items;
      case "Event":
        return box.events;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    dynamic elements = getElementMapByTyp(typ);

    return Column(
      mainAxisSize: MainAxisSize.min,
      
      children: [
        Container(
          height: 48,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: gradients?.beigeGradient,
              border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          ),
          child: Row(
            children: [
              SizedBox(width: 24,),
              Expanded(
                child: Text(
                  typ,
                  // TODO text anpassen
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Icon(Icons.keyboard_arrow_down_outlined, size: 32,),
              )
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: elements.length,
          itemBuilder: (context, index) {
            String key = elements.keys.elementAt(index);
            var element = elements[key];
            return ListElement(
              element: element,
              onDelete: () {},
            );
          },
        )
      ],
    );
  }
}


