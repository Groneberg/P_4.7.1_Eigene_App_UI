import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

Future<bool> showDeleteConfirmationDialog(
  BuildContext context, {
  required String title,
}) async {
  
  final bool? didConfirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return UserPromptAlertDialog(
        promptText: title,
      );
    },
  );

  return didConfirm ?? false;
}

class UserPromptAlertDialog extends StatelessWidget {
  final String promptText;
  const UserPromptAlertDialog({super.key, required this.promptText});

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            // padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: gradients?.beigeGradient,
              border: Border.all(color: Theme.of(context).colorScheme.tertiary),
            ),
            child: Center(
              child: Text(
                promptText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: gradients?.greenGradient,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Yes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 20, height: 40, color: Theme.of(context).colorScheme.secondary),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: gradients?.greenGradient,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "No",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}