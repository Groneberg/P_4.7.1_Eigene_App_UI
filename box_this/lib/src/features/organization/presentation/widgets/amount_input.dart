import 'package:box_this/src/features/organization/presentation/widgets/label_name.dart';
import 'package:flutter/material.dart';

class AmountInput extends StatefulWidget {
  // TODO amount in variable
  const AmountInput({super.key});

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LabelName(labelName: "Amount", labelWidth: 80,),
        // TODO Fragen nach auslagern 
        // AmountInputField()
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            child: TextField(
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                // TODO TextEditingController 
                hintText: "0",
                border: InputBorder.none,
              ),
            ),
          ),
          

        )
      ]
    );
  }
}