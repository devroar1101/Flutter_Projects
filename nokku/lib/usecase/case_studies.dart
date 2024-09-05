import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/project.dart';
import 'package:nokku/model/usecase.dart';
import 'package:nokku/provider/repo_provider.dart';
import 'package:nokku/usecase/add_casestudy.dart';
import 'package:tuple/tuple.dart';

class CaseStudiesList extends ConsumerStatefulWidget {
  const CaseStudiesList({
    super.key,
    required this.useCase,
    required this.project,
  });

  final UseCase useCase;
  final Project project;

  @override
  ConsumerState<CaseStudiesList> createState() {
    return CaseStudiesListState();
  }
}

class CaseStudiesListState extends ConsumerState<CaseStudiesList> {
  void onClickFloatingButton(CaseStudy? caseStudy) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: AddCasestudy(
          usecase: widget.useCase,
          project: widget.project,
          caseStudy: caseStudy,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final caseStudiesAsyncValue = ref.watch(
      casestudyListProvider(
        Tuple2(widget.useCase.id, widget.project.id),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.useCase.title),
      ),
      body: caseStudiesAsyncValue.when(
        data: (caseStudies) => ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: caseStudies.length,
          itemBuilder: (ctx, index) {
            final caseStudy = caseStudies[index];
            return InkWell(
              onLongPress: () {
                onClickFloatingButton(caseStudy);
              },
              child: ExpansionTile(
                title: Text(
                  '${index + 1}. ${caseStudy.title}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                tilePadding: const EdgeInsets.only(left: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      caseStudy.content,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onClickFloatingButton(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
