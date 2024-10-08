import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:vettigroup/chat/chat_room.dart';

import 'package:vettigroup/newsfeeds/screens.dart';

import 'package:vettigroup/widgets/nav_bar.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    _screens = [
      HomeScreen(
        userId: currentUserId,
      ),
      const ChatRoom(),
    ];
  }

  final List<IconData> _icons = [
    Icons.home,
    Icons.chat_bubble_outline,
  ];
  int _selectedScreen = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
          body: _screens[_selectedScreen],
          bottomNavigationBar: NavBar(
              icons: _icons,
              onTap: (index) => setState(() {
                    _selectedScreen = index;
                  }),
              selectIndex: _selectedScreen),
        ));
  }
}
