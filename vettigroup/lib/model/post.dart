import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum PostType { text, video, image }

class Post {
  final String id;
  final String userId;
  Timestamp createdAt;
  String type;
  String mediaUrl;
  String content;
  List<String> taggedUsers;
  String contentcolor;
  String contentfontcolor;

  Post(
      {String? id,
      required this.createdAt,
      required this.userId,
      required this.type,
      required this.mediaUrl,
      required this.content,
      required this.contentcolor,
      required this.contentfontcolor,
      List<String>? taggedUsers})
      : id = id ?? uuid.v4(),
        taggedUsers = taggedUsers ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'userId': userId,
      'type': type,
      'mediaUrl': mediaUrl,
      'content': content,
      'taggedUsers': taggedUsers,
      'contentcolor': contentcolor,
      'contentfontcolor': contentfontcolor,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        id: map['id'],
        createdAt: map['createdAt'],
        userId: map['userId'],
        type: map['type'],
        mediaUrl: map['mediaUrl'],
        content: map['content'],
        taggedUsers: (map['taggedUsers'] as List<dynamic>)
            .map((m) => m as String)
            .toList(),
        contentcolor: map['contentcolor'],
        contentfontcolor: map['contentfontcolor']);
  }
}

class FireStorePostRepository {
  FireStorePostRepository(this.firestore);

  FirebaseFirestore firestore;

  void addPost(Post post) async {
    await firestore.collection('posts').doc(post.id).set(post.toMap());
  }

  void updatePost(Post post) async {
    await firestore.collection('posts').doc(post.id).update(post.toMap());
  }

  void deletePost(Post post) async {
    await firestore.collection('posts').doc(post.id).delete();
  }

  Future<Post?> getPostById(String postId) async {
    final snapshot = await firestore.collection('posts').doc(postId).get();

    if (snapshot.exists) {
      return Post.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<List<Post?>> getAllPost() async {
    final snapshot = await firestore.collection('posts').get();

    return snapshot.docs
        .map(
          (m) => Post.fromMap(
            m.data(),
          ),
        )
        .toList();
  }

  Future<List<Post>> getPostsByUserId(userid) async {
    final snapshot = await firestore
        .collection('posts')
        .where('userId', isEqualTo: userid)
        .get();

    return snapshot.docs
        .map(
          (m) => Post.fromMap(
            m.data(),
          ),
        )
        .toList();
  }

  Stream<List<Post>> getNewsFeed(List<String> userIds) {
    return firestore
        .collection('posts')
        .where('userId', whereIn: userIds)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((m) => Post.fromMap(m.data())).toList();
    });
  }
}
