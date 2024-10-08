import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:vettigroup/config/palette.dart';

class VideoPicker extends StatelessWidget {
  const VideoPicker({super.key, required this.videoPicked});

  final void Function(File) videoPicked;

  @override
  Widget build(BuildContext context) {
    void pickImage(String type) async {
      final picker = ImagePicker();
      final File selectedVideo;
      final XFile? video;

      if (type == 'Camera') {
        video = await picker.pickVideo(source: ImageSource.camera);
      } else {
        video = await picker.pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(minutes: 1));
      }

      if (video == null) {
        return;
      } else {
        selectedVideo = File(video.path);

        videoPicked(selectedVideo);
        Navigator.pop(context);
      }
    }

    return Container(
      padding: const EdgeInsets.all(40),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                pickImage('Camera');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.camera,
                    size: 50,
                    color: Palette.vettiGroupColor,
                  ),
                  const Text('Camera'),
                ],
              )),
          InkWell(
              onTap: () {
                pickImage('Gallery');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.filter,
                    size: 50,
                    color: Palette.vettiGroupColor,
                  ),
                  const Text('Gallery'),
                ],
              )),
        ],
      ),
    );
  }
}
