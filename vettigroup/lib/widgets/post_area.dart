import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vettigroup/data/data.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/widgets/post_bottom.dart';
import 'package:vettigroup/widgets/post_head.dart';
import 'package:video_player/video_player.dart';

class PostArea extends StatefulWidget {
  const PostArea({super.key, required this.post});

  final Post post;

  @override
  State<PostArea> createState() => _PostAreaState();
}

class _PostAreaState extends State<PostArea> {
  VideoPlayerController? videoController;

  bool videoPlay = false;

  @override
  void initState() {
    super.initState();

    if (widget.post.type == PostType.video) {
      videoController = VideoPlayerController.network(widget.post.mediaUrl)
        ..initialize().then((_) {
          setState(() {
            videoController!.play();
            videoPlay = true;
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
    final AppUser user =
        appUserList.firstWhere((u) => u.userId == widget.post.userId);

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHead(post: widget.post, user: user),
          const SizedBox(height: 4),
          Text(widget.post.content),
          const SizedBox(height: 6),
          widget.post.type == PostType.image
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CachedNetworkImage(imageUrl: widget.post.mediaUrl),
                )
              : widget.post.type == PostType.video &&
                      videoController != null &&
                      videoController!.value.isInitialized
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          videoController!.pause();
                        });
                      },
                      child: Container(
                        child: AspectRatio(
                          aspectRatio: videoController!.value.aspectRatio,
                          child: VideoPlayer(videoController!),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: PostBottom(),
          )
        ],
      ),
    );
  }
}
