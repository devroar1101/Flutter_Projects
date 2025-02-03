import 'package:flutter/material.dart';
import 'package:vettigroup/post/create_post.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/profile/profile_screen.dart';

import 'package:vettigroup/widgets/profile_avatar.dart';

// ignore: must_be_immutable
class NewPost extends StatelessWidget {
  NewPost({super.key, required this.user});

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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => ProfileScreen(user: user),
                    ),
                  );
                },
                child: ProfileAvatar(
                  imageUrl: user.profilePicture,
                  isActive: true,
                  notSeen: false,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => CreatePost(user: user),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text("What's on your mind?"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
