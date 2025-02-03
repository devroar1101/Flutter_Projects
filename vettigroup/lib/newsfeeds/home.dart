import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/map/map.dart';

import 'package:vettigroup/provider/post_provider.dart';
import 'package:vettigroup/provider/user_provider.dart';
import 'package:vettigroup/widgets/loader.dart';

import 'package:vettigroup/newsfeeds/widgets/story_board.dart';
import 'package:vettigroup/widgets/widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key, required this.userId});
  String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersnapshot = ref.watch(singleUserSnapshot(userId));

    return usersnapshot.when(
      data: (user) {
        final postAsyncValue = ref.watch(feedsProvider(user!.connections));
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => const VgramMap()));
                },
                child: Text('Vgram',
                    style: TextStyle(
                      color: Palette.vettiGroupColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.2,
                    )),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                  iconData: Icons.exit_to_app,
                  iconSize: 30,
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: NewPost(user: user),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
              sliver: SliverToBoxAdapter(
                child: StoryBoard(
                  currentUser: user,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 4),
              sliver: postAsyncValue.when(
                data: (posts) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      final post = posts[index];
                      return PostArea(
                        post: post,
                        user: user,
                      );
                    }, childCount: posts.length),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: Center(
                    child:
                        CircularProgressIndicator(), // Wrapped in SliverToBoxAdapter
                  ),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Center(
                    child: Text('Error: $error '),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Loader(type: 1),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
