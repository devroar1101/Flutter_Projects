import 'package:animated_emoji/animated_emoji.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/reaction.dart';
import 'package:vettigroup/provider/reaction_provider.dart';
import 'package:vettigroup/widgets/loader.dart';

class PostBottom extends StatelessWidget {
  const PostBottom({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                showAnimatedIcons(context);
              },
              child: Container(
                height: 30, // Set both height and width for a circle
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200], // Define your custom color here
                ),
                child: Icon(
                  Icons.sentiment_satisfied,
                  size: 25, // Increase icon size
                  color: Palette.vettiGroupColor,
                ),
              ),
            ),
            ReactedArea(post: post),
            Expanded(
              child: Container(
                height: 30, // Set both height and width for a circle
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200], // Define your custom color here
                ),
                child: Icon(
                  Icons.comment,
                  size: 20.0, // Increase icon size
                  color: Palette.vettiGroupColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAnimatedIcons(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Center(
            child: Text('React',
                style: TextStyle(
                  fontSize: 20,
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

              return GestureDetector(
                onTap: () {
                  // Handle emoji selection (e.g., store it)
                  Navigator.of(ctx).pop(); // Close the dialog
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

class ReactedArea extends ConsumerStatefulWidget {
  const ReactedArea({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  ConsumerState<ReactedArea> createState() => _ReactedAreaState();
}

class _ReactedAreaState extends ConsumerState<ReactedArea> {
  @override
  Widget build(BuildContext context) {
    final reactionAsyncValue = ref.watch(getReactionForPost(widget.post.id));

    return reactionAsyncValue.when(
      data: (reactions) {
        // Here, you would typically use the reactions fetched from the database.
        // For demonstration, I'm using a static list of reactions.
        reactions = [
          Reaction(
              reactIndex: 1,
              createdAt: Timestamp.now(),
              postId: widget.post.id,
              userid: widget.post.userId),
          Reaction(
              reactIndex: 1,
              createdAt: Timestamp.now(),
              postId: widget.post.id,
              userid: widget.post.userId),
          Reaction(
              reactIndex: 1,
              createdAt: Timestamp.now(),
              postId: widget.post.id,
              userid: widget.post.userId),
          Reaction(
              reactIndex: 5,
              createdAt: Timestamp.now(),
              postId: widget.post.id,
              userid: widget.post.userId),
        ];

        final reactionCountMap = <int, int>{};

        for (Reaction r in reactions) {
          reactionCountMap[r.reactIndex] =
              (reactionCountMap[r.reactIndex] ?? 0) + 1;
        }

        return Row(
          children: reactionCountMap.entries.map((entry) {
            final reactIndex = entry.key;
            final count = entry.value;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedEmoji(AnimatedEmojis.values[
                    reactIndex]), // Replace `idex` with the actual index
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200], // Define your custom color here
                  ),
                  padding: const EdgeInsets.only(
                      left: 1, top: 4, right: 4, bottom: 4),
                  child: Text(
                    count.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
      error: (e, t) => const Text('Error loading reactions'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
