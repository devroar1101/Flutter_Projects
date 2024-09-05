import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/project.dart';
import 'package:nokku/model/usecase.dart';
import 'package:nokku/provider/repo_provider.dart';

// ignore: must_be_immutable
class AddUseCase extends ConsumerStatefulWidget {
  AddUseCase({super.key, required this.project, this.useCase});

  final Project project;

  UseCase? useCase;

  @override
  ConsumerState<AddUseCase> createState() {
    return AddUseCaseState();
  }
}

class AddUseCaseState extends ConsumerState<AddUseCase> {
  final textControl = TextEditingController();
  bool isStared = false;

  @override
  void initState() {
    super.initState();

    if (widget.useCase != null) {
      textControl.text = widget.useCase!.title;
      isStared = widget.useCase!.isStared;
    }
  }

  // ignore: non_constant_identifier_names
  void AddUsecase() async {
    if (textControl.text.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      final repo = ref.read(useCaseRepoProvider);

      if (widget.useCase != null) {
        widget.useCase!
          ..title = textControl.text
          ..isStared = isStared;
      }

      final usecase = widget.useCase ??
          UseCase(
              textControl.text, user!.uid, DateTime.now().toIso8601String(), [],
              isStared: isStared);

      await repo.addUsecase(widget.project.id, usecase);

      // ignore: unused_result
      ref.refresh(usecaseListProvider(widget.project.id));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    textControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: textControl,
            decoration: InputDecoration(
              hintText: 'Enter Usecase title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
            onPressed: () {
              setState(() {
                isStared = !isStared;
              });
            },
            icon: Icon(isStared ? Icons.star : Icons.star_border)),

        const SizedBox(width: 4),
        // Add some spacing between the TextField and the button
        TextButton.icon(
          onPressed: AddUsecase,
          label: Text(widget.useCase == null ? 'Add' : 'Save'),
          icon: const Icon(Icons.add),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
