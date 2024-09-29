import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum PostType { text, video, image }

class Post {
  final String id;
  final String userId;
  final Timestamp createdAt;
  final PostType type;
  final String mediaUrl;
  final String content;

  Post(
      {String? id,
      required this.createdAt,
      required this.userId,
      required this.type,
      required this.mediaUrl,
      required this.content})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'userId': userId,
      'type': type.name,
      'mediaUrl': mediaUrl,
      'content': content,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        id: map['id'],
        createdAt: map[' createdAt'],
        userId: map[' userId'],
        type: map[' type'],
        mediaUrl: map[' mediaUrl'],
        content: map[' content']);
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
}
