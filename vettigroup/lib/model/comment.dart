import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Comment {
  final String id;
  final String userid;
  final String content;
  final Timestamp createdAt;
  final String postId;

  Comment(
      {String? id,
      required this.content,
      required this.createdAt,
      required this.postId,
      required this.userid})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
      'postId': postId,
      'userid': userid,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
        id: map['id'],
        content: map[' content'],
        createdAt: map[' createdAt'],
        postId: map[' postId'],
        userid: map[' userid']);
  }
}

class FireStoreCommentRepository {
  FireStoreCommentRepository(this.firestore);

  FirebaseFirestore firestore;

  void addComment(Comment comment) async {
    await firestore.collection('comments').doc(comment.id).set(comment.toMap());
  }

  void updateComment(Comment comment) async {
    await firestore
        .collection('comments')
        .doc(comment.id)
        .update(comment.toMap());
  }

  void deleteComment(Comment comment) async {
    await firestore.collection('comments').doc(comment.id).delete();
  }

  Future<Comment?> getCommentById(String commentId) async {
    final snapshot =
        await firestore.collection('comments').doc(commentId).get();

    if (snapshot.exists) {
      return Comment.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<List<Comment?>> getAllComment() async {
    final snapshot = await firestore.collection('comments').get();

    return snapshot.docs
        .map(
          (m) => Comment.fromMap(
            m.data(),
          ),
        )
        .toList();
  }
}
