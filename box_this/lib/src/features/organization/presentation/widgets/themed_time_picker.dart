import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemedTimePicker extends StatefulWidget {
  final GradientsExtension? gradients;
  final Function(int hour, int minute)? onTimeSelected;

  const ThemedTimePicker({
    super.key,
    required this.gradients,
    this.onTimeSelected,
  });

  @override
  State<ThemedTimePicker> createState() => _ThemedTimePickerState();
}

class _ThemedTimePickerState extends State<ThemedTimePicker> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 280,
        height: 240,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(gradient: widget.gradients?.beigeGradient),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: widget.gradients?.greenGradient,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Enter Time",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 72,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: TextFormField(
                      controller: _hourController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF4E0F19),
                        fontSize: 36,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Center(
                      child: Text(
                        ":",
                        style: TextStyle(
                          color: const Color(0xFF4E0F19),
                          fontSize: 52,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 72,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: TextFormField(
                      controller: _minuteController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(2),
                      ],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF4E0F19),
                        fontSize: 36,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 64,
                    child: Text(
                      "Hour",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 64,
                    child: Text(
                      "Minute",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.tertiary,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO Handle Cancel action
                      _hourController.clear();
                      _minuteController.clear();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Color.fromRGBO(194, 8, 8, 1),
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final int? hour = int.tryParse(_hourController.text) ?? 0;
                      final int? minute =
                          int.tryParse(_minuteController.text) ?? 0;

                      if (hour != null && minute != null) {
                        widget.onTimeSelected?.call(hour, minute);
                      }
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}