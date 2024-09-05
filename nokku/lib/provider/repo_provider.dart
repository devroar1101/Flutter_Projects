import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/color.dart';
import 'package:nokku/model/project.dart';
import 'package:nokku/model/usecase.dart';
import 'package:nokku/model/utility.dart';
import 'package:tuple/tuple.dart';

final projectRepoProvider = Provider((ref) {
  return FireStoreProjectRepository(FirebaseFirestore.instance);
});

final useCaseRepoProvider = Provider((ref) {
  return FireStoreUseCaseRepository(FirebaseFirestore.instance);
});

final caseStudyRepoProvider = Provider((ref) {
  return FireStoreCaseStudyRepository(FirebaseFirestore.instance);
});

final colorRepoProvider = Provider((ref) {
  return ColorsRepositary(FirebaseFirestore.instance);
});

final utilityProvider = Provider((ref) {
  return UtilityRepositary(FirebaseFirestore.instance);
});

final projectListProvider = FutureProvider<List<Project>>((ref) async {
  final repository = ref.watch(projectRepoProvider);
  return await repository.gettAllProjects();
});

final usecaseListProvider =
    FutureProvider.family<List<UseCase>, String>((ref, projectId) async {
  final repo = ref.watch((useCaseRepoProvider));

  return await repo.gettAllUseCase(projectId);
});

final casestudyListProvider =
    FutureProvider.family<List<CaseStudy>, Tuple2<String, String>>(
        (ref, params) async {
  final repo = ref.watch(caseStudyRepoProvider);
  return await repo.gettAllCaseStudy(params.item1, params.item2);
});

final chosenColorListProvider = FutureProvider<List<ChosenColor>>((ref) async {
  final repo = ref.watch(colorRepoProvider);
  return await repo.getAllChosenColors();
});

final utilityListProvider = FutureProvider<List<Utility>>((ref) async {
  final repo = ref.watch(utilityProvider);
  return await repo.getAllLib();
});
