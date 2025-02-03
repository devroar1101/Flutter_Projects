import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class EntityType {
  String type;
  String id;

  EntityType(this.type, String? id) : id = id ?? const Uuid().v4();

  // Convert from Map to EntityType
  factory EntityType.fromMap(Map<String, dynamic> map) {
    return EntityType(
      map['type'] as String,
      map['id'] as String,
    );
  }

  // Convert from EntityType to Map
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'id': id,
    };
  }
}

class EntityTypeFireStoreRepository {
  final FirebaseFirestore _fireStore;

  EntityTypeFireStoreRepository(this._fireStore);

  // Add new entity type
  Future<void> addEntityType(EntityType entityType) async {
    await _fireStore
        .collection('entityType')
        .doc(entityType.id)
        .set(entityType.toMap());
  }

  // Update an existing entity type
  Future<void> updateEntityType(EntityType entityType) async {
    await _fireStore
        .collection('entityType')
        .doc(entityType.id)
        .update(entityType.toMap());
  }

  // Delete an entity type by ID
  Future<void> deleteEntityType(String id) async {
    await _fireStore.collection('entityType').doc(id).delete();
  }

  // Get an entity type by ID
  Future<EntityType?> getEntityTypeById(String id) async {
    DocumentSnapshot doc =
        await _fireStore.collection('entityType').doc(id).get();
    if (doc.exists) {
      return EntityType.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Get all entity types
  Future<List<EntityType>> getAllEntityTypes() async {
    QuerySnapshot querySnapshot =
        await _fireStore.collection('entityType').get();

    return querySnapshot.docs
        .map((doc) => EntityType.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
