import 'package:box_this/src/features/organization/presentation/screens/home_screen.dart';
import 'package:box_this/src/theme/custom_extensions/gradients_extension.dart';
import 'package:flutter/material.dart';

class CustomBottemNavBar extends StatelessWidget {
  const CustomBottemNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final gradients = Theme.of(context).extension<GradientsExtension>();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.tertiary,
          width: 1.0, // 1px
        ),
        gradient: gradients?.beigeGradient,
      ),
      child: Row(
        spacing: 16,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TODO vielleicht eigees svg für menu
          GestureDetector(
            onTap: () {
              navigatetoHomeScreen(context);
            },
            child: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 32,
            ),
          ),
          Container(
            width: 16,
            height: 64,
            decoration: BoxDecoration(gradient: gradients?.greenGradient),
          ),
          Expanded(child: Container()),
          Container(
            width: 16,
            height: 64,
            decoration: BoxDecoration(gradient: gradients?.greenGradient),
          ),

          // TODO vielleicht eigees svg für menu
          Icon(
            Icons.menu,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 32,
          ),
        ],
      ),
    );
  }

  void navigatetoHomeScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      // MaterialPageRoute(
      //   builder: (context) => HomeScreen(),
      // ),
    );
  }
}
