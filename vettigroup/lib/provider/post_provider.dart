import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/post.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

final postProvider = Provider((fn) {
  return FireStorePostRepository(_firebaseFirestore);
});

final feedsProvider =
    StreamProvider.family<List<Post>, List<String>>((ref, userIds) {
  final repo = ref.watch(postProvider);

  return repo.getNewsFeed(userIds);
});
