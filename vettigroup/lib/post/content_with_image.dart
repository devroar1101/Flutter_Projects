import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/post/create_post_methods.dart';

// ignore: must_be_immutable
class ContentWithImage extends StatefulWidget {
  ContentWithImage(
      {super.key,
      required this.contentController,
      required this.selectedFile,
      required this.selectFile,
      this.networkImage});
  TextEditingController contentController;
  File? selectedFile;
  final Function(File) selectFile;
  String? networkImage;

  @override
  State<ContentWithImage> createState() => _ContentWithImageState();
}

class _ContentWithImageState extends State<ContentWithImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  GoogleFonts.poppins(fontSize: 15, color: Colors.grey[700]),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(5),
            ),
            showCursor: true,
            style: const TextStyle(fontSize: 15),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)),
              child: widget.selectedFile == null &&
                      (widget.networkImage == null || widget.networkImage == '')
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          pickImage(widget.selectFile, context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        pickImage(widget.selectFile, context);
                      },
                      child: Stack(
                        children: [
                          if (widget.networkImage == null)
                            Image.file(
                              widget.selectedFile!,
                              fit: BoxFit.cover,
                            ),
                          if (widget.networkImage != null)
                            Image.network(
                              widget.networkImage!,
                              fit: BoxFit.cover,
                            ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.selectedFile = null;
                                  widget.networkImage = null;
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                size: 35,
                                color: Palette.vettiGroupColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        ],
      ),
    );
  }
}
