import 'package:flutter/material.dart';

class CustomBottemNavBar extends StatelessWidget {
  const CustomBottemNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 24),
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
      child: Row(
        spacing: 16,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.home, color: const Color(0xFF4E0F19), size: 32),
          Container(
            width: 16,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xFF3A4801), const Color(0xFF7D9200)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            width: 16,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [const Color(0xFF3A4801),const Color(0xFF7D9200)],
                stops: [0.0, 1.0],
              ),
            ),
          ),
 

          // TODO vielleicht eigees svg für menu
          Icon(Icons.menu, color: const Color(0xFF4E0F19), size: 32),
        ],
      ),
    );
  }
}
