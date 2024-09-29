import 'package:flutter/material.dart';
import 'package:vettigroup/data/data.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/widgets/profile_avatar.dart';

// ignore: must_be_immutable
class Rooms extends StatelessWidget {
  Rooms({super.key});

  List<AppUser> userlist = appUserList;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 60.0,
        child: Row(children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: userlist.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                itemBuilder: (ctx, index) {
                  final AppUser appUser = userlist[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ProfileAvatar(
                      imageUrl: appUser.profilePicture,
                      isActive: false,
                      notSeen: false,
                    ),
                  );
                }),
          ),
        ]));
  }
}
