import 'package:flutter/material.dart';

class InputMark extends StatelessWidget {
  const InputMark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 20,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF3A4801),
            const Color(0xFF7D9200),
          ],
          stops: [0.0, 1.0],
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
