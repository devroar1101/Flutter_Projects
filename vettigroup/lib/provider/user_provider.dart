import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:vettigroup/model/user_index.dart';
import 'package:vettigroup/model/user.dart';

FirebaseFirestore _firestorerepo = FirebaseFirestore.instance;

final userRepoProvider = Provider((fn) {
  return FireStoreUserRepositorty(_firestorerepo);
});

final connectionProvider = Provider((fn) {
  return FireStoreUserIndexRepositary(_firestorerepo);
});

final singleUserSnapshot =
    FutureProvider.family<AppUser?, String>((ref, userId) {
  final repo = ref.watch(userRepoProvider);
  return repo.getUserById(userId);
});

final userListFromIdsProvider =
    FutureProvider.family<List<AppUser>, List<String>>(
  (ref, arg) {
    final repo = ref.watch(userRepoProvider);
    return repo.getUsersFromIds(arg);
  },
);
