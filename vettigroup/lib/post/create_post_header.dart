import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/post/create_post_methods.dart';
import 'package:vettigroup/widgets/loader.dart';
import 'package:vettigroup/widgets/widgets.dart';

class CreatePostHeader extends StatefulWidget {
  const CreatePostHeader({
    super.key,
    required this.user,
    required this.tagUser,
    required this.taggedUsers,
    required this.sharePost,
    required this.post,
    required this.type,
  });

  final AppUser user;
  final Function(String, String) tagUser;
  final List<String> taggedUsers;
  final Function() sharePost;
  final bool post;
  final String type;

  @override
  State<CreatePostHeader> createState() => CreatePostHeaderState();
}

class CreatePostHeaderState extends State<CreatePostHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ProfileAvatar(
            imageUrl: widget.user.profilePicture,
            isActive: true,
            notSeen: false,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.user.username,
                style: GoogleFonts.passionOne(
                    fontSize: 25, color: Colors.grey[800]),
              ),
              if (widget.type != 'Split')
                InkWell(
                  onTap: () {
                    tagUserModal(widget.taggedUsers, widget.user.connections,
                        context, widget.tagUser);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3, right: 2),
                        child: Icon(
                          Icons.people_alt_outlined,
                          size: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        // ignore: prefer_is_empty
                        widget.taggedUsers.length == 0
                            ? 'tag people'
                            : '- with ${widget.taggedUsers.length} other',
                        style: GoogleFonts.passionOne(
                            fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        widget.post
            ? const Loader(type: 2)
            : ElevatedButton(
                onPressed: widget.sharePost,
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  backgroundColor: WidgetStateProperty.all<Color>(Palette
                      .vettiGroupColor), // Set your desired background color here
                ),
                child: const Text('Post'),
              ),
      ],
    );
  }
}
