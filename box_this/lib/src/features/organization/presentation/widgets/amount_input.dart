import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';
import 'package:flutter/material.dart';

class AmountInput extends StatefulWidget {
  final String labelName;

  // TODO amount in variable
  const AmountInput({super.key, required this.labelName});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LabelName(labelName: widget.labelName, labelWidth: 80),
        // TODO Fragen nach auslagern
        // AmountInputField()
        Expanded(
          child: Container(
            // padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.tertiary),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  // TODO TextEditingController
                  hintText: "0",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        // TODO ausrichtung der icons
        IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 40,
          ),
        ),
        SizedBox(width: 8,),
        IconButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          icon: Icon(
            Icons.remove,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 40,
          ),
        ),
      ],
    );
  }
}
