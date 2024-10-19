import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/split.dart';
import 'package:vettigroup/post/content_with_color.dart';
import 'package:vettigroup/post/content_with_image.dart';
import 'package:vettigroup/post/content_with_split.dart';
import 'package:vettigroup/post/content_with_video.dart';
import 'package:vettigroup/post/create_post_content.dart';
import 'package:vettigroup/post/create_post_header.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/post/create_post_methods.dart';

import 'package:vettigroup/post/post_attachment.dart';

// ignore: must_be_immutable
class CreatePost extends StatefulWidget {
  CreatePost({super.key, required this.user, this.post, this.split});

  Post? post;
  SplitWise? split;

  final AppUser user;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String postType = 'None';
  final TextEditingController contentController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  File? selectedFile;
  List<String> taggedUsers = [];
  bool post = false;
  String contentColor = '';
  String contentFontColor = '';
  String? networkMedia;
  String? postId;
  DateTime? splitDate;

  @override
  void initState() {
    super.initState();
    amountController.text = '0';
    if (widget.post != null) {
      postType = widget.post!.type;
      contentController.text = widget.post!.content;
      taggedUsers = widget.post!.taggedUsers;
      contentColor = widget.post!.contentcolor;
      contentFontColor = widget.post!.contentfontcolor;
      networkMedia = widget.post!.mediaUrl;
      postId = widget.post!.id;
    }
    if (widget.split != null) {
      splitDate = widget.split!.splitDate.toDate();
      amountController.text = widget.split!.amount.toString();
    }
  }

  void changePostType(String type) {
    setState(() {
      postType = type;
      selectedFile = null;
      contentColor = '';
      contentFontColor = '';
      taggedUsers = [];
    });
  }

  void updateSplitDate() async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        currentDate: DateTime.now());
    setState(() {
      splitDate = date;
    });
  }

  void triggerPost() {
    setState(() {
      post = true;
    });
  }

  void sharePost() {
    savePost(
        user: widget.user,
        content: contentController.text,
        amount: amountController.text,
        triggerPost: triggerPost,
        context: context,
        contentColor: contentColor,
        contentFontColor: contentFontColor,
        file: selectedFile,
        taggedUsers: taggedUsers,
        type: postType,
        networkMedia: networkMedia,
        currentpost: widget.post,
        date: Timestamp.fromDate(splitDate ?? DateTime.now()),
        split: widget.split);
  }

  void selectFile(File file) {
    setState(() {
      selectedFile = file;
      networkMedia = null;
    });
  }

  void tagUser(String id, type) {
    setState(() {
      if (type == 'add') {
        taggedUsers.add(id);
      } else {
        taggedUsers.remove(id);
      }
    });
  }

  void setColorContent(contentColor, contentFontColor) {
    this.contentColor = contentColor;
    this.contentFontColor = contentFontColor;
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CreatePostHeader(
                  user: widget.user,
                  tagUser: tagUser,
                  taggedUsers: taggedUsers,
                  post: post,
                  sharePost: sharePost,
                  type: postType,
                ),
              ),
              if (postType == 'None')
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CreatePostContent(
                    contentController: contentController,
                  ),
                ),
              if (postType == 'Color')
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ContentWithColor(
                    contentController: contentController,
                    setContentColor: setColorContent,
                    contentColor: contentColor,
                    contentFontColor: contentFontColor,
                  ),
                ),
              if (postType == 'Image')
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ContentWithImage(
                    contentController: contentController,
                    selectFile: selectFile,
                    selectedFile: selectedFile,
                    networkImage: networkMedia,
                  ),
                ),
              if (postType == 'Video')
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ContentWithVideo(
                      contentController: contentController,
                      selectFile: selectFile,
                      selectedFile: selectedFile,
                      networkVideo: networkMedia,
                    ),
                  ),
                ),
              if (postType == 'Split')
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ContentWithSplit(
                    contentController: contentController,
                    amountController: amountController,
                    tagUser: tagUser,
                    taggedUser: taggedUsers,
                    user: widget.user,
                    updateDate: updateSplitDate,
                    splitDate: splitDate,
                  ),
                )
            ],
          ),
        ),
        floatingActionButton: PostAttachment(
          changePostType: changePostType,
          selectFile: selectFile,
        ));
  }
}
