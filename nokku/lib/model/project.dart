import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Project {
  Project(this.title, this.createdBy, this.createdAt,
      {this.isDeleted = false, String? id})
      : id = id ?? uuid.v4();

  final String id;

  String title;

  final bool isDeleted;

  final String createdBy;

  final String createdAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDeleted': isDeleted,
      'createdBy': createdBy,
      'createdAt': createdAt,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      id: map['id'],
      map['title'],
      map['createdBy'],
      map['createdAt'],
    );
  }
}

class FireStoreProjectRepository {
  FireStoreProjectRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<void> addProject(Project project) async {
    await _firestore
        .collection('projects')
        .doc(project.id)
        .set(project.toMap());
  }

  Future<void> updateProject(Project project) async {
    await _firestore
        .collection('projects')
        .doc(project.id)
        .update(project.toMap());
  }

  Future<void> deleteProject(String projectId) async {
    await _firestore.collection('projects').doc(projectId).delete();
  }

  Future<List<Project>> gettAllProjects() async {
    final docSnapshot = await _firestore.collection('projects').get();

    return docSnapshot.docs.map((map) => Project.fromMap(map.data())).toList();
  }

  Future<Project?> getProjectById(String projectId) async {
    final docSnapshot =
        await _firestore.collection('projects').doc(projectId).get();

    if (docSnapshot.exists) {
      return Project.fromMap(docSnapshot.data()!);
    }
    return null;
  }
}
