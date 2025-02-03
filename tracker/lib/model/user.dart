import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    required this.username,
    required this.email,
    required this.userId,
    required this.profilePicture,
    String? entityId,
    String? deviceId,
    required this.role,
  })  : deviceId = deviceId ?? '',
        entityId = entityId ?? '';
  String username;
  final String email;
  final String userId;
  String entityId;
  String deviceId;
  String role;
  String profilePicture;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      'entityId': entityId,
      'deviceId': deviceId,
      'role': role
    };
  }

  factory AppUser.toMap(Map<String, dynamic> map) {
    return AppUser(
        username: map['username'],
        email: map['email'],
        userId: map['userId'],
        profilePicture: map['profilePicture'],
        entityId: map['entityId'],
        deviceId: map['deviceId'],
        role: map['deviceId']);
  }
}

class FireStoreUserRepositorty {
  FireStoreUserRepositorty(this._firestore);

  final FirebaseFirestore _firestore;

  void addUser(AppUser user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toMap());
  }
}
