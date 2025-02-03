import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Entity {
  final String id;
  String type;
  String parentId;
  String name;

  Entity(String? id,
      {required this.type, required this.name, required this.parentId})
      : id = id ?? uuid.v4();

  // Convert from Map to Entity
  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      map['id'] as String,
      type: map['type'] as String,
      name: map['name'] as String,
      parentId: map['parentId'],
    );
  }

  // Convert from Entity to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'parentId': parentId,
    };
  }
}

class EntityFireStoreRepository {
  final FirebaseFirestore _firestore;

  EntityFireStoreRepository(this._firestore);

  // Add new entity
  Future<void> addEntity(Entity entity) async {
    await _firestore.collection('entities').doc(entity.id).set(entity.toMap());
  }

  // Update an existing entity
  Future<void> updateEntity(Entity entity) async {
    await _firestore
        .collection('entities')
        .doc(entity.id)
        .update(entity.toMap());
  }

  // Delete an entity by ID
  Future<void> deleteEntity(String id) async {
    await _firestore.collection('entities').doc(id).delete();
  }

  // Get an entity by ID
  Future<Entity?> getEntityById(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection('entities').doc(id).get();
    if (doc.exists) {
      return Entity.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Get all entities
  Future<List<Entity>> getAllEntities() async {
    QuerySnapshot querySnapshot = await _firestore.collection('entities').get();
    return querySnapshot.docs
        .map((doc) => Entity.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
