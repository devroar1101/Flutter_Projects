import 'package:flutter/material.dart';
import 'package:vettigroup/config/palette.dart';

class NavBar extends StatelessWidget {
  final List<IconData> icons;
  final Function(int) onTap;
  final int selectIndex;

  const NavBar(
      {super.key,
      required this.icons,
      required this.onTap,
      required this.selectIndex});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: icons.map(
        (e) {
          return Icon(
            e,
            color: Palette.vettiGroupColor,
          );
        },
      ).toList(),
      onTap: onTap,
    );
  }
}
