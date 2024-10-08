import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  const AppVideoPlayer({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  bool _isButtonVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.controller.value.isPlaying) {
            widget.controller.pause();
          } else {
            widget.controller.play();
          }
          _isButtonVisible = !_isButtonVisible; // Hide the button after press
        });
      },
      child: Stack(
        alignment: Alignment.center, // Center the button
        children: [
          AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
          if (_isButtonVisible)
            IconButton(
              icon: Icon(
                Icons.play_arrow,
                size: 80,
                color: Colors.white.withOpacity(0.7), // Button transparency
              ),
              onPressed: () {
                setState(() {
                  if (widget.controller.value.isPlaying) {
                    widget.controller.pause();
                  } else {
                    widget.controller.play();
                  }
                  _isButtonVisible = false; // Hide the button after press
                });
              },
            ),
        ],
      ),
    );
  }
}
