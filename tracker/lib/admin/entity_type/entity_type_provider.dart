import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/model/entity_type.dart';

class EntityTypeState {
  final List<EntityType> entityTypes;
  final bool isLoading;
  final String? error;

  EntityTypeState({
    this.entityTypes = const [],
    this.isLoading = true,
    this.error,
  });

  EntityTypeState copyWith({
    List<EntityType>? entityTypes,
    bool? isLoading,
    String? error,
  }) {
    return EntityTypeState(
      entityTypes: entityTypes ?? this.entityTypes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class EntityTypeNotifier extends StateNotifier<EntityTypeState> {
  final EntityTypeFireStoreRepository repository;

  EntityTypeNotifier(this.repository) : super(EntityTypeState());

  Future<void> loadEntityTypes() async {
    try {
      final entityTypes = await repository.getAllEntityTypes();

      state = state.copyWith(entityTypes: entityTypes, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to fetch entity types: $e',
      );
    }
  }

  Future<void> addEntityType(EntityType entityType) async {
    try {
      await repository.addEntityType(entityType);
      await loadEntityTypes();
    } catch (e) {
      state = state.copyWith(error: 'Failed to add entity type: $e');
    }
  }

  Future<void> updateEntityType(EntityType entityType) async {
    try {
      await repository.updateEntityType(entityType);
      await loadEntityTypes();
    } catch (e) {
      state = state.copyWith(error: 'Failed to update entity type: $e');
    }
  }

  Future<void> deleteEntityType(String id) async {
    try {
      await repository.deleteEntityType(id);
      await loadEntityTypes();
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete entity type: $e');
    }
  }
}

// Provider for Riverpod
final entityTypeProvider =
    StateNotifierProvider<EntityTypeNotifier, EntityTypeState>((ref) {
  final repository = EntityTypeFireStoreRepository(FirebaseFirestore.instance);
  return EntityTypeNotifier(repository);
});

final contryProvider = Provider((ref) {
  return ['inida' 'America'];
});
