import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CreatePostContent extends StatefulWidget {
  CreatePostContent({super.key, required this.contentController});

  TextEditingController contentController;

  @override
  State<CreatePostContent> createState() => CreatePostContentState();
}

class CreatePostContentState extends State<CreatePostContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: widget.contentController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "What's on your mind?",
              hintStyle:
                  GoogleFonts.poppins(fontSize: 20, color: Colors.grey[700]),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(5),
            ),
            showCursor: true,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
