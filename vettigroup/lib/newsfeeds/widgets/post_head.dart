import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/split.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/people/tag_people_area.dart';
import 'package:vettigroup/post/create_post.dart';
import 'package:vettigroup/provider/split_provider.dart';
import 'package:vettigroup/widgets/widgets.dart';

// ignore: must_be_immutable
class PostHead extends ConsumerWidget {
  PostHead({super.key, required this.post, required this.user, this.split});

  final Post post;
  final AppUser user;
  SplitWise? split;

  void showTaggedUser(
    context,
  ) {
    showBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (ctx) => SizedBox(
              height: 400,
              child: TagPeopleArea(
                  connections: post.taggedUsers,
                  taggedUsersIds: post.taggedUsers),
            ));
  }

  void deletePost(post) {
    final repo = FireStorePostRepository(FirebaseFirestore.instance);
    repo.deletePost(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    split = ref.watch(splitNotifier);
    DateTime postDate = post.createdAt.toDate();

    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(postDate);

    int taggedUserCount = post.taggedUsers.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Row(
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
                if (taggedUserCount == 0)
                  Text(
                    user.username,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                    ),
                  ),
                if (taggedUserCount > 0)
                  Row(
                    children: [
                      Text(
                        user.username,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[800],
                        ),
                      ),
                      if (post.type != 'Split')
                        GestureDetector(
                          onTap: () {
                            showTaggedUser(context);
                          },
                          child: Text(
                            '- with $taggedUserCount other ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Palette.vettiGroupColor,
                            ),
                          ),
                        )
                    ],
                  ),
                Text(formattedDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ))
              ],
            ),
          ),
          if (user.userId == post.userId)
            Center(
              child: PopupMenuButton(
                  icon: const Icon(Icons.linear_scale),
                  color: Colors.white,
                  iconColor: Palette.vettiGroupColor,
                  itemBuilder: (ctx) {
                    return [
                      PopupMenuItem(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => CreatePost(
                                  user: user,
                                  post: post,
                                  split: split,
                                ),
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 15,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text('edit'),
                            ],
                          )),
                      PopupMenuItem(
                        onTap: () {
                          deletePost(post);
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 15,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text('delete'),
                          ],
                        ),
                      )
                    ];
                  }),
            )
        ],
      ),
    );
  }
}
