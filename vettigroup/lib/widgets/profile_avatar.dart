import 'package:flutter/material.dart';
import 'package:vettigroup/config/palette.dart';

// ignore: must_be_immutable
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar(
      {super.key,
      required this.imageUrl,
      required this.isActive,
      required this.notSeen});

  final String imageUrl;
  final bool isActive;
  final bool notSeen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Palette.vettiGroupColor,
          child: CircleAvatar(
            radius: notSeen ? 17 : 20,
            backgroundColor: Colors.grey[300],
            backgroundImage: imageUrl != ''
                ? NetworkImage(
                    imageUrl,
                  )
                : const AssetImage('assets/gifs/profile.gif'),
          ),
        ),
        isActive
            ? Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.online,
                      border: Border.all(width: 2.0, color: Colors.white)),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
