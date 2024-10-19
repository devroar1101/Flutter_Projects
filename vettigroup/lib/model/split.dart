import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class SplitWise {
  final String postId;
  String id;
  double amount;
  List<String> paidUser;
  Timestamp splitDate;

  SplitWise(
      {required this.postId,
      required this.amount,
      required this.paidUser,
      required this.splitDate,
      String? id})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'amount': amount,
      'id': id,
      'paidUser': paidUser,
      'splitDate': splitDate
    };
  }

  factory SplitWise.fromMap(Map<String, dynamic> map) {
    return SplitWise(
        postId: map['postId'],
        amount: map['amount'],
        paidUser:
            (map['paidUser'] as List<dynamic>).map((m) => m as String).toList(),
        id: map['id'],
        splitDate: map['splitDate']);
  }
}

class FireStoreSplitWiseRepository {
  final FirebaseFirestore _firestore;
  FireStoreSplitWiseRepository(this._firestore);

  void addSplitWise(SplitWise split) async {
    await _firestore.collection('splits').doc(split.id).set(split.toMap());
  }

  void updateSplitWise(SplitWise split) async {
    await _firestore.collection('splits').doc(split.id).update(split.toMap());
  }

  void split(SplitWise split) async {
    await _firestore.collection('splits').doc(split.id).delete();
  }

  Stream<SplitWise?> getSplitWiseByPostId(String postId) {
    return _firestore
        .collection('splits')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return null;
      } // Return null if no documents found
      return SplitWise.fromMap(snapshot.docs.first.data());
    });
  }
}
