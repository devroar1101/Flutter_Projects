import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Reaction {
  final String id;
  final String userid;
  final int reactIndex;
  final Timestamp createdAt;
  final String postId;

  Reaction(
      {String? id,
      required this.reactIndex,
      required this.createdAt,
      required this.postId,
      required this.userid})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reactIndex': reactIndex,
      'createdAt': createdAt,
      'postId': postId,
      'userid': userid,
    };
  }

  factory Reaction.fromMap(Map<String, dynamic> map) {
    return Reaction(
        id: map['id'],
        reactIndex: map['reactIndex'],
        createdAt: map['createdAt'],
        postId: map['postId'],
        userid: map['userid']);
  }
}

class FireStoreReactionRepository {
  FireStoreReactionRepository(this.firestore);

  FirebaseFirestore firestore;

  void addReaction(Reaction reaction) async {
    await firestore
        .collection('reactions')
        .doc(reaction.id)
        .set(reaction.toMap());
  }

  void updateReaction(Reaction reaction) async {
    await firestore
        .collection('Reactions')
        .doc(reaction.id)
        .update(reaction.toMap());
  }

  void deleteReaction(Reaction reaction) async {
    await firestore.collection('reactions').doc(reaction.id).delete();
  }

  Future<Reaction?> getReactionById(String reactionId) async {
    final snapshot =
        await firestore.collection('reactions').doc(reactionId).get();

    if (snapshot.exists) {
      return Reaction.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<List<Reaction?>> getAllReaction() async {
    final snapshot = await firestore.collection('reactions').get();

    return snapshot.docs
        .map(
          (m) => Reaction.fromMap(
            m.data(),
          ),
        )
        .toList();
  }

  Future<List<Reaction>> getAllReactionsFromPost(String postId) async {
    final snapshot = await firestore
        .collection('reactions')
        .where('postId', isEqualTo: postId)
        .get(); // Use get() instead of snapshots() for one-time fetch

    return snapshot.docs
        .map((doc) => Reaction.fromMap(doc.data()))
        .toList(); // Convert documents to Reaction objects
  }
}
