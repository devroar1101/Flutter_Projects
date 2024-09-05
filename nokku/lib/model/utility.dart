import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum LibType { widget, package, function, issues }

const libTypeIcons = {
  LibType.function: Icons.code,
  LibType.package: Icons.card_giftcard,
  LibType.widget: Icons.widgets,
  LibType.issues: Icons.bug_report,
};

class Utility {
  Utility(this.title, this.description, this.content, this.createdBy,
      this.createdAt, this.type,
      {String? id})
      : id = id ?? uuid.v4();
  final String id;
  String title;
  String description;
  String content;
  String createdBy;
  String createdAt;
  LibType type;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'type': type.name,
    };
  }

  factory Utility.fromMap(Map<String, dynamic> map) {
    final libType = LibType.values.firstWhere((e) => e.name == map['type']);
    return Utility(map['title'], map['description'], map['content'],
        map['createdBy'], map['createdAt'], libType);
  }
}

class UtilityRepositary {
  UtilityRepositary(this.firestore);
  final FirebaseFirestore firestore;

  void add(Utility utility) async {
    await firestore.collection('utility').doc(utility.id).set(utility.toMap());
  }

  Future<List<Utility>> getAllLib() async {
    final snapShot = await firestore.collection('utility').get();

    return snapShot.docs.map((m) => Utility.fromMap(m.data())).toList();
  }
}
