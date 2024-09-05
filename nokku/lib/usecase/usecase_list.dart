import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/project.dart';
import 'package:nokku/model/usecase.dart';
import 'package:nokku/provider/repo_provider.dart';
import 'package:nokku/usecase/add_usecase.dart';
import 'package:nokku/usecase/case_studies.dart';

class UseCaseList extends ConsumerStatefulWidget {
  const UseCaseList({super.key, required this.project});

  final Project project;

  ConsumerState<UseCaseList> createState() {
    return UsecaseListState();
  }
}

class UsecaseListState extends ConsumerState<UseCaseList> {
  void onClickFloatingButton({UseCase? usecase}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: 100,
          child: AddUseCase(
            project: widget.project,
            useCase: usecase,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final useCasesAsynValue = ref.watch(usecaseListProvider(widget.project.id));

    // String fullDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(
          widget.project.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      )),
      body: useCasesAsynValue.when(
        data: (useCases) => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: useCases.length,
          itemBuilder: (ctx, index) {
            final useCase = useCases[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CaseStudiesList(
                      useCase: useCase,
                      project: widget.project,
                    ),
                  ),
                );
              },
              onLongPress: () {
                onClickFloatingButton(usecase: useCase);
              },
              leading: Text(
                (index + 1).toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  useCase.title,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              trailing: useCase.isStared ? const Icon(Icons.star) : null,
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: onClickFloatingButton,
      ),
    );
  }
}
