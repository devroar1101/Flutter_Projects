import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/split.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

final splitProvider = Provider((ref) {
  return FireStoreSplitWiseRepository(firestore);
});

final getSplitDetail = StreamProvider.family<SplitWise?, String>(
  (ref, postId) {
    final repo = ref.read(splitProvider);
    return repo.getSplitWiseByPostId(postId);
  },
);

class SplitStateNotifier extends StateNotifier<SplitWise?> {
  SplitStateNotifier() : super(null);

  void updateSplit(SplitWise split) {
    state = split;
  }
}

final splitNotifier =
    StateNotifierProvider<SplitStateNotifier, SplitWise?>((ref) {
  return SplitStateNotifier();
});
