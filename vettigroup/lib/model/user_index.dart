import 'package:cloud_firestore/cloud_firestore.dart';

class UserIndex {
  final String id;
  UserIndex(this.id);

  Map<String, String> toMap() {
    return {'id': id};
  }

  factory UserIndex.fromMap(Map<String, String> map) {
    return UserIndex(map['id'] as String);
  }
}

class FireStoreUserIndexRepositary {
  FirebaseFirestore _fireStore;

  FireStoreUserIndexRepositary(this._fireStore);
  void addConnection(userId, UserIndex UserIndex) async {
    await _fireStore
        .collection('users')
        .doc(userId)
        .collection('connection')
        .add(UserIndex.toMap());
  }

  Future<List<UserIndex>> getAllConnection(userid) async {
    final snapShot = await _fireStore
        .collection('users')
        .doc(userid)
        .collection('connection')
        .get();

    return snapShot.docs
        .map(
          (m) => UserIndex.fromMap(
            m.data() as Map<String, String>,
          ),
        )
        .toList();
  }
}
