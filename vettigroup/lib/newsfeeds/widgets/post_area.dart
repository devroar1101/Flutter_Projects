import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/split.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/newsfeeds/widgets/split_post.dart';
import 'package:vettigroup/provider/user_provider.dart';
import 'package:vettigroup/widgets/loader.dart';
import 'package:vettigroup/newsfeeds/widgets/post_bottom.dart';
import 'package:vettigroup/newsfeeds/widgets/post_head.dart';
import 'package:vettigroup/widgets/video_player.dart';
import 'package:video_player/video_player.dart';

class PostArea extends ConsumerStatefulWidget {
  const PostArea({super.key, required this.post, required this.user});

  final Post post;
  final AppUser user;

  @override
  ConsumerState<PostArea> createState() => _PostAreaState();
}

class _PostAreaState extends ConsumerState<PostArea> {
  VideoPlayerController? videoController;

  bool videoPlay = false;

  bool onTapContent = false;

  SplitWise? split;

  void openContent() {
    setState(() {
      if (widget.post.content.length > 100) {
        onTapContent = !onTapContent;
      }
    });
  }

  void updateSplit(SplitWise split) {
    if (mounted) {
      setState(() {
        this.split = split;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.post.type == 'Video') {
      videoController = VideoPlayerController.network(widget.post.mediaUrl)
        ..initialize().then((_) {
          setState(() {
            videoController!.setLooping(true);
          });
        });
    }
  }

  @override
  void dispose() {
    videoController?.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use ref directly here
    final usersnapshot = ref.watch(singleUserSnapshot(widget.post.userId));

    return usersnapshot.when(
      data: (user) {
        return Container(
          margin: const EdgeInsets.only(top: 5, left: 3, right: 3),
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostHead(
                post: widget.post,
                user: user!,
                split: split,
              ),
              const SizedBox(height: 4),
              if (widget.post.type == 'Image' || widget.post.type == 'Video')
                Text(widget.post.content),
              const SizedBox(height: 6),
              widget.post.type == 'Image' || widget.post.type == 'Video'
                  ? widget.post.type == 'Image'
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CachedNetworkImage(
                              imageUrl: widget.post.mediaUrl),
                        )
                      : widget.post.type == 'Video' &&
                              videoController != null &&
                              videoController!.value.isInitialized
                          ? AppVideoPlayer(controller: videoController!)
                          : Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height:
                                    200, // Ensure this is the right height for your design
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey,
                                ), // Set a color to indicate the shimmer area
                              ),
                            )
                  : PostContent(
                      post: widget.post,
                      onTapContent: onTapContent,
                      openContent: openContent,
                      updateSplit: updateSplit,
                    ),
              PostBottom(
                post: widget.post,
                user: widget.user,
              )
            ],
          ),
        );
      },
      error: (e, t) => Text('Error: $e '),
      loading: () => Loader(type: 2),
    );
  }
}

// ignore: must_be_immutable
class PostContent extends StatelessWidget {
  final Post post;
  final bool onTapContent;
  void Function() openContent;
  void Function(SplitWise) updateSplit;

  PostContent(
      {super.key,
      required this.post,
      required this.onTapContent,
      required this.openContent,
      required this.updateSplit});

  @override
  Widget build(BuildContext context) {
    return post.type == 'Split'
        ? SplitPost(post: post, updateSplit: updateSplit)
        : post.type != 'Color'
            ? InkWell(
                onTap: openContent,
                child: Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 10),
                    height: onTapContent
                        ? 350
                        : post.content.length < 100
                            ? post.content.length + 50
                            : 100,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Text(
                          post.content.length > 100 && !onTapContent
                              ? '${post.content.substring(0, 150)}...more'
                              : post.content,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: 300,
                width: 550,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(int.parse(
                        post.contentcolor.replaceFirst('0x', ''),
                        radix: 16))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            post.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(
                                int.parse(
                                  post.contentfontcolor.replaceFirst('0x', ''),
                                  radix: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
  }
}
