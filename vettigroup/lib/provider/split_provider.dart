import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/model/split.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

final splitProvider = Provider((ref) {
  return FireStoreSplitWiseRepository(firestore);
});
