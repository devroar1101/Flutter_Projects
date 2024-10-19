import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Comment {
  final String id;
  final String userid;
  final String userName;
  final String mediaUrl;
  final String content;
  final Timestamp createdAt;
  final String postId;

  Comment(
      {String? id,
      required this.content,
      required this.createdAt,
      required this.postId,
      required this.userid,
      required this.userName,
      required this.mediaUrl})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
      'postId': postId,
      'userid': userid,
      'userName': userName,
      'mediaUrl': mediaUrl
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      content: map['content'],
      createdAt: map['createdAt'],
      postId: map['postId'],
      userid: map['userid'],
      mediaUrl: map['mediaUrl'],
      userName: map['userName'],
    );
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

  Stream<List<Comment>> getCommentsByPostId(String postId) {
    return firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map(
            (m) => Comment.fromMap(
              m.data(),
            ),
          )
          .toList();
    });
  }
}
