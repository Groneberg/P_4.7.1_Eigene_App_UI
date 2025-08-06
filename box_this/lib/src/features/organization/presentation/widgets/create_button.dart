import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [const Color(0xFF3A4801), const Color(0xFF7D9200)],
          stops: [0.0, 1.0],
        ),
        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
      ),
      child: Center(
        child: Text(
          "Creat",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
