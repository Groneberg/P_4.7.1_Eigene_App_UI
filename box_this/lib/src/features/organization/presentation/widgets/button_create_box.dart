import 'package:flutter/material.dart';

class ButtonCreateBox extends StatefulWidget {
  const ButtonCreateBox({super.key});

  @override
  State<ButtonCreateBox> createState() => _ButtonCreateBoxState();
}

class _ButtonCreateBoxState extends State<ButtonCreateBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF3A4801),
          width: 1.0, // 1px
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [const Color(0xFFF1D5AE), const Color(0xFFDBB77F), const Color(0xFFDFB983)],
          stops: [0.0, 0.5564, 1.0],
        ),
      ),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF3A4801),
              width: 2.0, // 1px
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [const Color(0xFFF1D5AE), const Color(0xFFDBB77F), const Color(0xFFDFB983)],
              stops: [0.0, 0.5564, 1.0],
            ),
          ),
          child: Icon(Icons.add, color: const Color(0xFF4E0F19), size: 36),
        ),
      ),
    );
  }
}
