import 'package:animated_emoji/animated_emoji.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/reaction.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/provider/reaction_provider.dart';
import 'package:vettigroup/widgets/loader.dart';

class PostBottom extends ConsumerStatefulWidget {
  const PostBottom({super.key, required this.post, required this.user});

  final Post post;
  final AppUser user;

  @override
  ConsumerState<PostBottom> createState() => _PostBottomState();
}

class _PostBottomState extends ConsumerState<PostBottom> {
  List<Reaction> reactions = [];

  void updateList(reaction, type) {
    setState(() {
      if (type == 'add') {
        reactions.add(reaction);
      } else if (type == 'update') {
        final index = reactions.indexOf(reaction);
        reactions.remove(reaction);

        reactions.insert(index, reaction);
      } else if (type == 'remove') {
        reactions.remove(reaction);
      }
    });
  }

  Widget postBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5, top: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showAnimatedIcons(
                context: context,
                postId: widget.post.id,
                userId: widget.user.userId,
                reactions: reactions,
                updateList: updateList,
                ref: ref,
              );
            },
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.sentiment_satisfied,
                      size: 25,
                      color: Palette.vettiGroupColor,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    ReactedArea(
                      post: widget.post,
                      reactions: reactions,
                      ref: ref,
                      userId: widget.user.userId,
                      updateClick: updateList,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    Icons.comment,
                    size: 20.0,
                    color: Palette.vettiGroupColor,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    Icons.share,
                    size: 20.0,
                    color: Palette.vettiGroupColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reactionAsyncValue = ref.watch(getReactionForPost(widget.post.id));

    return reactionAsyncValue.when(
      data: (data) {
        reactions = data;

        return postBottomWidget();
      },
      error: (e, t) => const Text('Error loading reactions'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

void updateReactClick(
    {required List<Reaction> reactions,
    Reaction? reaction,
    userId,
    postId,
    required WidgetRef ref,
    required int reactIndex,
    required Function(Reaction, String) updateClick}) {
  final repo = ref.watch(reactionProvider);
  Reaction? existReaction = reactions.firstWhere((r) => r.userId == userId,
      orElse: () => Reaction(
          reactIndex: 1000,
          createdAt: Timestamp.now(),
          postId: postId,
          userId: userId));

  {
    // ignore: unnecessary_null_comparison
    if (existReaction.reactIndex == 1000) {
      final newReaction = Reaction(
          reactIndex: reactIndex,
          createdAt: Timestamp.now(),
          postId: postId,
          userId: userId);
      repo.addReaction(newReaction);
      updateClick(newReaction, 'add');
      // ignore: unnecessary_null_comparison
    } else if (existReaction != null && reaction!.reactIndex == 1000) {
      existReaction.reactIndex = reactIndex;
      repo.updateReaction(existReaction);
      updateClick(existReaction, 'update');
    } else {
      repo.deleteReaction(existReaction);
      updateClick(existReaction, 'remove');
    }
  }
}

void showAnimatedIcons(
    {required BuildContext context,
    required List<Reaction> reactions,
    required String postId,
    required String userId,
    updateList,
    required WidgetRef ref}) {
  showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Center(
            child: Text('React',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[800],
                ))),
        content: SizedBox(
          width: double.maxFinite,
          height: 300, // Adjust height as needed
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,

              // Set a reasonable height for the items
            ),
            itemCount: AnimatedEmojis.values.length,
            itemBuilder: (ctx, index) {
              final emoji = AnimatedEmojis.values[index];

              return InkWell(
                onTap: () {
                  final repo = ref.watch(reactionProvider);

                  Reaction? reaction = reactions.firstWhere(
                    (reaction) =>
                        reaction.postId == postId && reaction.userId == userId,
                    orElse: () => Reaction(
                      reactIndex: 1000,
                      createdAt: Timestamp.now(),
                      postId: postId,
                      userId: userId,
                    ),
                  );

                  if (reaction.reactIndex == 1000) {
                    reaction.reactIndex = index;
                    repo.addReaction(reaction);

                    updateList(reaction, 'add');
                  } else {
                    reaction.createdAt = Timestamp.now();
                    reaction.reactIndex = index;

                    repo.updateReaction(reaction);
                    updateList(reaction, 'update');
                  }

                  Navigator.of(ctx).pop();
                },
                child: AnimatedEmoji(emoji,
                    errorWidget: const Loader(
                      type: 2,
                    )),
              );
            },
          ),
        ),
      );
    },
  );
}

class ReactedArea extends StatelessWidget {
  const ReactedArea(
      {super.key,
      required this.post,
      required this.reactions,
      required this.ref,
      required this.userId,
      required this.updateClick});

  final Post post;
  final List<Reaction> reactions;
  final WidgetRef ref;
  final String userId;
  final Function(Reaction, String) updateClick;

  @override
  Widget build(BuildContext context) {
    final reactionCountMap = <int, int>{};

    for (Reaction r in reactions) {
      reactionCountMap[r.reactIndex] =
          (reactionCountMap[r.reactIndex] ?? 0) + 1;
    }

    return Row(
      children: reactionCountMap.entries.map((entry) {
        final reactIndex = entry.key;
        final count = entry.value;

        final reaction = reactions.firstWhere(
          (r) =>
              r.postId == post.id &&
              r.userId == userId &&
              r.reactIndex == reactIndex,
          orElse: () => Reaction(
            reactIndex: 1000, // Use a special index to signify "no reaction"
            createdAt: Timestamp.now(),
            postId: post.id,
            userId: userId,
          ),
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                updateReactClick(
                    reactions: reactions,
                    ref: ref,
                    postId: post.id,
                    userId: userId,
                    reaction: reaction,
                    reactIndex: reactIndex,
                    updateClick: updateClick);
              },
              child: AnimatedEmoji(
                AnimatedEmojis.values[reactIndex],
                size: 20,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.vettiGroupColor.withOpacity(0.5),
              ),
              padding:
                  const EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 4),
              child: Text(
                count.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
