import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/data/data.dart';
import 'package:vettigroup/model/story.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/widgets/profile_avatar.dart';

// ignore: must_be_immutable
class StoryBoard extends StatelessWidget {
  StoryBoard({super.key, required this.currentUser});

  AppUser currentUser;

  List<Story> storyList = stories;
  List<AppUser> users = appUserList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        itemCount: storyList.length + 1,
        itemBuilder: (ctx, index) {
          // Handle the first "Add Story" item separately
          if (index == 0) {
            return Stack(
              children: [
                Container(
                  height: 150,
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),

                  //decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: currentUser.profilePicture != ''
                        ? Image.network(
                            // ignore: unnecessary_null_comparison
                            currentUser.profilePicture,

                            fit: BoxFit.cover,
                          )
                        : Image.asset('assets/gifs/profile.gif'),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 30.0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Palette.vettiGroupColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        )),
                  ),
                ),
              ],
            );
          }

          // For the rest of the stories
          Story story = storyList[index - 1];
          AppUser? user = users.firstWhere(
            (u) => u.userId == story.userid,
            // Handle missing user cases
          );

          return Stack(
            children: [
              Container(
                height: 150,
                width: 100,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                //decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: story.mediaUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error), // Handle image load errors
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 30.0,
                child: ProfileAvatar(
                  imageUrl: user.profilePicture,
                  isActive: false,
                  notSeen: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
