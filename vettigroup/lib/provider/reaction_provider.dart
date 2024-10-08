import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/reaction.dart';

final reactionProvider =
    Provider((fn) => FireStoreReactionRepository(FirebaseFirestore.instance));

final getReactionForPost = FutureProvider.family<List<Reaction>, String>(
  (ref, postId) {
    final repo = ref.watch(reactionProvider);

    return repo.getAllReactionsFromPost(postId);
  },
);
