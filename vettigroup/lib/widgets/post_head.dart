import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/widgets/widgets.dart';

class PostHead extends StatelessWidget {
  const PostHead({super.key, required this.post, required this.user});

  final Post post;
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    DateTime postDate = post.createdAt.toDate();

    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(postDate);

    return Row(
      children: [
        ProfileAvatar(
            imageUrl: user.profilePicture, isActive: false, notSeen: false),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
              Text(formattedDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ))
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.linear_scale,
              color: Colors.grey[700],
            ))
      ],
    );
  }
}
