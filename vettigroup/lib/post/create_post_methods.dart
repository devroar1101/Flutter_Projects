import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/post.dart';
import 'package:vettigroup/model/split.dart';
import 'package:vettigroup/model/user.dart';
import 'package:path/path.dart' as p;
import 'package:vettigroup/people/tag_people.dart';
import 'package:vettigroup/provider/post_provider.dart';
import 'package:vettigroup/newsfeeds/widgets/photo_picker.dart';
import 'package:vettigroup/provider/split_provider.dart';
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
  required String amount,
  File? file,
  List<String>? taggedUsers,
  type,
  context,
  required contentColor,
  required contentFontColor,
  required Function() triggerPost,
  networkMedia,
  Post? currentpost,
  SplitWise? split,
  required Timestamp date,
}) async {
  if ((type == 'None' || type == 'Color') && content.trim().isEmpty) {
   
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please type something to post'),
      ),
    );
    return;
  } else if (((type == 'Video' || type == 'Image') &&
      file == null &&
      networkMedia == null)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please upload file'),
      ),
    );
    return;
  } else if (type == 'Split' &&
      (content.trim().isEmpty ||
          amount.trim().isEmpty ||
          taggedUsers!.isEmpty)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:
            Text('Please enter bill details , amount and tag peoples to split'),
      ),
    );
    return;
  } else {
    triggerPost();

    final container = ProviderContainer();
    final repo = container.read(postProvider);
    final splitRepo = container.read(splitProvider);

    String mediaUrl = '';
    Post post;

    if (currentpost != null) {
      currentpost.createdAt = Timestamp.now();
      currentpost.type = type;
      currentpost.mediaUrl = mediaUrl;
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
          mediaUrl: mediaUrl,
          content: content,
          contentcolor: contentColor,
          contentfontcolor: contentFontColor,
          taggedUsers: taggedUsers);
    }

    if (file == null || (networkMedia != null && networkMedia != '')) {
      if (networkMedia != null) {
        mediaUrl = networkMedia;
        post.mediaUrl = mediaUrl;
      }
    } else if (type == 'Video' || type == 'Image') {
      if (post != null) {
        final fileExtension = p.extension(file.path);
        final storeMedia = FirebaseStorage.instance
            .ref('PostGalley')
            .child('${post.id}.$fileExtension');
        await storeMedia.putFile(file);

        mediaUrl = await storeMedia.getDownloadURL();
        post.mediaUrl = mediaUrl;
      }
    }

    if (currentpost != null) {
      repo.updatePost(post);
    } else {
      repo.addPost(post);
    }

    if (type == 'Split') {
      final newSplit = SplitWise(
          postId: post.id,
          amount: double.tryParse(amount) ?? 0,
          paidUser: [],
          splitDate: date);

      if (split != null) {
        newSplit.id = split.id;
        split = newSplit;
        splitRepo.updateSplitWise(split);
      } else {
        splitRepo.addSplitWise(newSplit);
      }
    }

    Navigator.pop(context);
  }
}
