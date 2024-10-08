import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/user.dart';
import 'package:path/path.dart' as p;
import 'package:vettigroup/people/tag_people.dart';
import 'package:vettigroup/provider/post_provider.dart';
import 'package:vettigroup/newsfeeds/widgets/photo_picker.dart';
import 'package:vettigroup/widgets/video_picker.dart';
import 'package:video_player/video_player.dart';

void pickImage(selectImage, context) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => PhotoPicker(
      imagePicked: selectImage,
    ),
  );
}

void pickVideo(selectVideo, context) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) => VideoPicker(videoPicked: selectVideo),
  );
}

void tagUserModal(taggedUsers, connections, context, tagUser) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => TagPeople(
        connections: connections,
        taggedUsersIds: taggedUsers,
        tagUser: tagUser,
      ),
    ),
  );
}

VideoPlayerController? createController(File selectedFile) {
  // ignore: unnecessary_null_comparison
  if (selectedFile != null) {
    final videoController = VideoPlayerController.file(selectedFile);
    videoController.initialize().then((_) => videoController.play());
    return videoController;
  }
  return null;
}

void savePost({
  required AppUser user,
  required String content,
  File? file,
  List<String>? taggedUsers,
  type,
  context,
  required contentColor,
  required contentFontColor,
  required Function() triggerPost,
  networkMedia,
  Post? currentpost,
}) async {
  if (type == 'None' && type == 'Color' && content.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please Type Something'),
      ),
    );
    return;
  } else if ((type != 'None' &&
      type != 'Color' &&
      file == null &&
      networkMedia == null)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please upload file'),
      ),
    );
    return;
  } else {
    triggerPost();

    final container = ProviderContainer();
    final repo = container.read(postProvider);
    String meadiaUrl = '';
    Post post;

    if (currentpost != null) {
      currentpost.createdAt = Timestamp.now();
      currentpost.type = type;
      currentpost.mediaUrl = meadiaUrl;
      currentpost.content = content;
      currentpost.contentcolor = contentColor;
      currentpost.contentfontcolor = contentFontColor;
      currentpost.taggedUsers = taggedUsers!;

      post = currentpost;
    } else {
      post = Post(
          createdAt: Timestamp.now(),
          userId: user.userId,
          type: type,
          mediaUrl: meadiaUrl,
          content: content,
          contentcolor: contentColor,
          contentfontcolor: contentFontColor,
          taggedUsers: taggedUsers);
    }

    if (file == null && networkMedia != null && networkMedia != '') {
      meadiaUrl = networkMedia;
      post.mediaUrl = meadiaUrl;
    } else if (type != 'None' && type != 'Color') {
      final fileExtension = p.extension(file!.path);
      final storeMedia = FirebaseStorage.instance
          .ref('PostGalley')
          .child('${post.id}.$fileExtension');
      await storeMedia.putFile(file);

      meadiaUrl = await storeMedia.getDownloadURL();

      post.mediaUrl = meadiaUrl;
    }

    if (currentpost != null) {
      repo.updatePost(post);
    } else {
      repo.addPost(post);
    }

    Navigator.pop(context);
  }
}
