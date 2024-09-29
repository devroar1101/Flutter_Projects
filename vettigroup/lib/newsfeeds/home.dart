import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/data/data.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/provider/user_provider.dart';
import 'package:vettigroup/widgets/loader.dart';

import 'package:vettigroup/widgets/story_board.dart';
import 'package:vettigroup/widgets/widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key, required this.userId});
  String userId;
  final posts = mockPosts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersnapshot = ref.watch(singleUserSnapshot(userId));

    return usersnapshot.when(
      data: (user) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Vetti Grp',
                style: TextStyle(
                  color: Palette.vettiGroupColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                  iconData: Icons.message,
                  iconSize: 30,
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: CreatePost(user: user!),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
              sliver: SliverToBoxAdapter(
                child: StoryBoard(
                  currentUser: user,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                final Post post = posts[index];
                return PostArea(post: post);
              }, childCount: posts.length),
            ),
          ],
        );
      },
      loading: () => const Loader(type: 1),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
