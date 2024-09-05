import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class UseCase {
  UseCase(this.title, this.createdBy, this.createdAt, this.caseStudies,
      {this.isDeleted = false, this.isStared = false, String? id})
      : this.id = id ?? uuid.v4();

  String id;
  String title;
  String createdBy;
  String createdAt;
  bool isDeleted;
  bool isStared;
  final List<CaseStudy> caseStudies;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'isDeleted': isDeleted,
      'isStared': isStared,
      'caseStudies': caseStudies.isNotEmpty
          ? caseStudies.map((cs) => cs.toMap()).toList()
          : [],
    };
  }

  factory UseCase.FromMap(Map<String, dynamic> map) {
    return UseCase(
      map['title'],
      map['createdBy'],
      map['createdAt'],
      isDeleted: map['isDeleted'],
      isStared: map['isStared'],
      id: map['id'],
      List<CaseStudy>.from(
        map['caseStudies'].map(
          (csMap) => CaseStudy.fromMap(csMap),
        ),
      ),
    );
  }
}

class CaseStudy {
  CaseStudy(this.title, this.content, this.createdBy, this.createdAt,
      {this.isDeleted = false, String? id})
      : id = id ?? uuid.v4();
  final String id;
  String title;
  String content;
  String createdBy;
  String createdAt;
  final bool isDeleted;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'isDeleted': isDeleted
    };
  }

  factory CaseStudy.fromMap(Map<String, dynamic> map) {
    return CaseStudy(map['title'] as String, map['content'] as String,
        map['createdBy'] as String, map['createdAt'] as String,
        id: map['id'] as String, isDeleted: map['isDeleted'] as bool);
  }
}

class FireStoreUseCaseRepository {
  final FirebaseFirestore _firestore;

  FireStoreUseCaseRepository(this._firestore);

  Future<void> addUsecase(String projectId, UseCase useCase) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCase.id)
        .set(useCase.toMap());
  }

  Future<void> updateUseCase(String projectId, UseCase useCase) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCase.id)
        .update(useCase.toMap());
  }

  Future<void> deleteUseCase(String projectId, String useCaseId) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .delete();
  }

  Future<List<UseCase>> gettAllUseCase(String projectId) async {
    final docSnapshot = await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .get();

    return docSnapshot.docs
        .map(
          (map) => UseCase.FromMap(
            map.data(),
          ),
        )
        .toList();
  }

  Future<UseCase?> getUseCaseById(String projectId, String useCaseId) async {
    final docSnapshot = await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .get();

    if (docSnapshot.exists) {
      return UseCase.FromMap(docSnapshot.data()!);
    }
    return null;
  }
}

class FireStoreCaseStudyRepository {
  final FirebaseFirestore _firestore;

  FireStoreCaseStudyRepository(this._firestore);

  Future<void> AddCaseStudy(
      String projectId, String useCaseId, CaseStudy caseStudy) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .collection('casestudies')
        .doc(caseStudy.id)
        .set(caseStudy.toMap());
  }

  Future<void> updateCaseStudy(
      String projectId, String useCaseId, CaseStudy caseStudy) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .collection('casestudies')
        .doc(caseStudy.id)
        .update(caseStudy.toMap());
  }

  Future<void> deleteCaseStudy(
      String projectId, String useCaseId, CaseStudy caseStudy) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .collection('casestudies')
        .doc(caseStudy.id)
        .delete();
  }

  Future<List<CaseStudy>> gettAllCaseStudy(
      String useCaseId, String projectId) async {
    final docSnapshot = await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .collection('casestudies')
        .get();

    return docSnapshot.docs
        .map(
          (map) => CaseStudy.fromMap(
            map.data(),
          ),
        )
        .toList();
  }

  Future<CaseStudy?> getCaseStudyById(
      String projectId, String useCaseId, String caseStudyId) async {
    final docSnapshot = await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('usecases')
        .doc(useCaseId)
        .collection('casestudies')
        .doc(caseStudyId)
        .get();

    if (docSnapshot.exists) {
      return CaseStudy.fromMap(docSnapshot.data()!);
    }
    return null;
  }
}
