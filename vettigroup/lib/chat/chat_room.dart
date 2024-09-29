import 'package:flutter/material.dart';
import 'package:vettigroup/widgets/rooms.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Rooms(),
          ),
        )
      ],
    );
  }
}
