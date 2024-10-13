import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:vettigroup/config/palette.dart';

class PostAttachment extends StatelessWidget {
  const PostAttachment(
      {super.key, required this.changePostType, required this.selectFile});

  final Function(String) changePostType;
  final Function(File) selectFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 5),
      child: SpeedDial(
        icon: Icons.attachment,
        activeIcon: Icons.close,
        direction: SpeedDialDirection.left,
        backgroundColor: Colors.grey,
        buttonSize: const Size.fromRadius(30),
        childPadding: const EdgeInsets.all(8),
        childrenButtonSize: const Size.fromRadius(28),
        children: [
          SpeedDialChild(
            backgroundColor: Palette.vettiGroupColor,
            onTap: () {
              changePostType('None');
            },
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          SpeedDialChild(
            backgroundColor: Palette.vettiGroupColor,
            onTap: () {
              changePostType('Split');
            },
            child: const Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
          ),
          SpeedDialChild(
            onTap: () {
              changePostType('Video');
            },
            backgroundColor: Palette.vettiGroupColor,
            child: const Icon(
              Icons.video_call,
              color: Colors.white,
            ),
          ),
          SpeedDialChild(
            backgroundColor: Palette.vettiGroupColor,
            onTap: () {
              changePostType('Image');
            },
            child: const Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
          SpeedDialChild(
            backgroundColor: Colors.amber,
            onTap: () {
              changePostType('Color');
            },
            child: const Icon(
              Icons.color_lens_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
