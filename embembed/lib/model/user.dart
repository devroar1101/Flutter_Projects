import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  const AppUser(
      {required this.username,
      required this.email,
      required this.userId,
      required this.profilePicture});
  final String username;
  final String email;
  final String userId;
  final String profilePicture;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
    };
  }

  factory AppUser.toMap(Map<String, dynamic> map) {
    return AppUser(
        username: map['username'],
        email: map['email'],
        userId: map['userId'],
        profilePicture: map['profilePicture']);
  }
}

class FireStoreUserRepositorty {
  FireStoreUserRepositorty(this._firestore);

  final FirebaseFirestore _firestore;

  void addUser(AppUser user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toMap());
  }
}
