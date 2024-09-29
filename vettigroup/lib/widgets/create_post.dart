import 'package:flutter/material.dart';
import 'package:vettigroup/model/user.dart';

import 'package:vettigroup/widgets/profile_avatar.dart';

// ignore: must_be_immutable
class CreatePost extends StatelessWidget {
  CreatePost({super.key, required this.user});

  AppUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              ProfileAvatar(
                imageUrl: user.profilePicture,
                isActive: true,
                notSeen: false,
              ),
              const SizedBox(
                width: 8,
              ),
              const Expanded(
                  child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'what\'s on your mind ?'),
              ))
            ],
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {},
                label: const Text('photo'),
                icon: const Icon(
                  Icons.photo,
                  color: Colors.green,
                ),
              ),
              const VerticalDivider(
                width: 8.0,
              ),
              TextButton.icon(
                onPressed: () {},
                label: const Text('video'),
                icon: const Icon(
                  Icons.video_call,
                  color: Colors.purpleAccent,
                ),
              ),
              const VerticalDivider(
                width: 8.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
