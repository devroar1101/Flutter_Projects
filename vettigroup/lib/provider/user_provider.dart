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

// final connectionSnapshot =
//     FutureProvider.family<List<UserIndex>, String>((ref, userId) {
//   final repo = ref.watch(connectionProvider);

//   return repo.getAllConnection(userId);
// });

// final userConnectionProvider = Provider.family<List<UserIndex>, String>(
//   (ref, userId) {
//     final repo = ref.watch(connectionSnapshot(userId));

//     return repo.maybeWhen(
//         data: (userIndexList) {
//           return userIndexList;
//         },
//         orElse: () => []);
//   },
// );
