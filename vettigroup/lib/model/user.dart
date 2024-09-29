import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class AppUser {
  const AppUser({
    required this.username,
    required this.email,
    required this.userId,
    required this.profilePicture,
    required this.phoneNumber,
    required this.gender,
    required this.bio,
    required this.connections,
    required this.connecting,
  });

  final String username;
  final String email;
  final String userId;
  final String profilePicture;
  final String gender;
  final int phoneNumber;
  final String bio;
  final List<String> connections;
  final List<String> connecting;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'connections': connections,
      'connecting': connecting
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        username: map['username'],
        email: map['email'],
        userId: map['userId'],
        profilePicture: map['profilePicture'],
        gender: map['gender'],
        phoneNumber: map['phoneNumber'],
        bio: map['bio'],
        connecting: (map['connecting'] as List<dynamic>)
            .map((m) => m as String)
            .toList(),
        connections: (map['connections'] as List<dynamic>)
            .map((m) => m as String)
            .toList());
  }
}

class FireStoreUserRepositorty {
  FireStoreUserRepositorty(this._firestore);

  final FirebaseFirestore _firestore;

  void addUser(AppUser user) async {
    await _firestore.collection('users').doc(user.userId).set(user.toMap());
  }

  void updateUser(AppUser user) async {
    await _firestore.collection('users').doc(user.userId).update(user.toMap());
  }

  Future<AppUser?> getUserById(userId) async {
    final snapshot = await _firestore.collection('users').doc(userId).get();

    if (snapshot.exists) {
      return AppUser.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<List<AppUser>> getAllUser() async {
    final snapShot = await _firestore.collection('users').get();

    return snapShot.docs.map((m) => AppUser.fromMap(m.data())).toList();
  }
}
