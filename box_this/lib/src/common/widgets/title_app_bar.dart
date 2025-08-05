import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class TiTleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool setBackIcon;
  // Icom icon;

  const TiTleAppBar({
    super.key,
    this.title = "Default Title",
    // this.setBackIcon = false,
    this.setBackIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [const Color(0xFF3A4801), const Color(0xFF7D9200)],
            stops: [0.0, 1.0],
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
            width: 1.0, // 1px
          ),
        ),
      ),
      elevation: 0,
      toolbarHeight: 48.0,
      // TODO anpassen des PFeiles
      automaticallyImplyLeading: setBackIcon,
      leading: setBackIcon
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(
              // TODO Schriftart anpassen
              fontFamily: 'Roboto',
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.only(right: 24.0), // Padding wie in deinem Original-Code
        //   child: SvgPicture.asset(
        //     'assets/icons/home_icon.svg', // Passe den Pfad zu deinem SVG an
        //     width: 32,
        //     height: 32,
        //     colorFilter: const ColorFilter.mode(Color(0xFFFAFAFA), BlendMode.srcIn), // SVG einfärben
        //   ),
        // ),
        IconButton(
          icon: Icon(Icons.home, size: 32, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            print('Home Icon gedrückt!');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0); // Höhe der AppBar anpassen
}
