import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/post/create_post_methods.dart';
import 'package:vettigroup/widgets/video_player.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class ContentWithVideo extends StatefulWidget {
  ContentWithVideo(
      {super.key,
      required this.contentController,
      required this.selectFile,
      required this.selectedFile,
      this.networkVideo});
  TextEditingController contentController;
  String? networkVideo;

  File? selectedFile;
  final Function(File) selectFile;

  @override
  State<ContentWithVideo> createState() => _ContentWithVideoState();
}

class _ContentWithVideoState extends State<ContentWithVideo> {
  late VideoPlayerController? videoController;
  bool isInitialized = false;

  void selectNewFile(File file) async {
    // ignore: unnecessary_null_comparison
    if (file != null) {
      try {
        if (widget.networkVideo == null) {
          videoController = VideoPlayerController.file(file);
        } else {
          Uri uri = Uri.parse(widget.networkVideo!);
          videoController = VideoPlayerController.networkUrl(uri);
        }

        await videoController!.initialize().then((_) {
          setState(() {
            isInitialized = true;
            widget.selectedFile = file;
            widget.selectFile(file);
            videoController!.setLooping(true);
          });
        }).catchError((error) {
          print('Video initialization failed: $error');
        });
      } catch (e) {
        print('Error initializing video controller: $e');
      }
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: widget.contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "What's on your mind?",
              hintStyle:
                  GoogleFonts.poppins(fontSize: 15, color: Colors.grey[700]),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(5),
            ),
            showCursor: true,
            style: const TextStyle(fontSize: 15),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: widget.selectedFile == null &&
                    (widget.networkVideo == null || widget.networkVideo == '')
                ? Center(
                    child: IconButton(
                      onPressed: () {
                        pickVideo(selectNewFile, context);
                      },
                      icon: Icon(
                        Icons.video_call,
                        size: 60,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : isInitialized
                    ? Stack(
                        children: [
                          AppVideoPlayer(controller: videoController!),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.selectedFile = null;
                                  widget.networkVideo = null;
                                  videoController!.dispose();
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                size: 35,
                                color: Palette.vettiGroupColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const CircularProgressIndicator(), // Show a loader while the video is being initialized
          ),
        ],
      ),
    );
  }
}
