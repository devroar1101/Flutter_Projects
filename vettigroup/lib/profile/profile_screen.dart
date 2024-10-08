import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/profile/update_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    // WidgetRef added

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: user.profilePicture == ''
              ? const AssetImage('assets/gifs/profile.gif')
              : NetworkImage(user.profilePicture),
          fit: BoxFit.cover, // Optional: adjust how the image should fit
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 200, 12, 0),
          child: Container(
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(50, 50),
                bottomLeft: Radius.elliptical(50, 50),
                bottomRight: Radius.elliptical(50, 50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: AvatarCliper(),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Palette.vettiGroupColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.elliptical(50, 50),
                                bottomRight: Radius.elliptical(50, 50),
                              )),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 11,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => UpdateProfile(
                                          user: user,
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: user.profilePicture == ''
                                        ? const AssetImage(
                                            'assets/gifs/profile.gif')
                                        : NetworkImage(user.profilePicture),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.username,
                                      style: GoogleFonts.passionOne(
                                          fontSize: 30, color: Colors.white),
                                    ),
                                    if (user.gender == 'Male')
                                      Icon(
                                        Icons.male,
                                        color: Palette.vettiGroupColor,
                                        size: 25,
                                      ),
                                    if (user.gender != 'Male')
                                      Icon(
                                        Icons.female,
                                        color: Palette.vettiGroupColor,
                                        size: 25,
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 18, left: 30, right: 10, bottom: 40),
                  child: Text(
                    user.bio,
                    style: GoogleFonts.passionOne(
                      fontSize: 20,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            user.connections.length.toString(),
                            style: buildStyle(Colors.black, 20),
                          ),
                          Text(
                            'Connection',
                            style: buildStyle(Colors.grey[700], 14),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 7,
                        color: Color.fromARGB(255, 12, 0, 0),
                      ),
                      Column(
                        children: [
                          Text(
                            '0',
                            style: buildStyle(Colors.black, 20),
                          ),
                          Text(
                            'Connecting',
                            style: buildStyle(Colors.grey[700], 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  TextStyle buildStyle(color, double size) {
    return GoogleFonts.montserrat(
        fontSize: size, color: color, fontWeight: FontWeight.bold);
  }
}

class AvatarCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(10, size.height)
      ..arcToPoint(
        Offset(114, size.height),
        radius: const Radius.circular(20),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
