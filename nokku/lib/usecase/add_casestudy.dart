import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/project.dart';
import 'package:nokku/model/usecase.dart';
import 'package:nokku/provider/repo_provider.dart';

// ignore: must_be_immutable
class AddCasestudy extends ConsumerStatefulWidget {
  AddCasestudy(
      {super.key,
      required this.usecase,
      required this.project,
      this.caseStudy});

  final UseCase usecase;
  final Project project;
  CaseStudy? caseStudy;

  @override
  ConsumerState<AddCasestudy> createState() => _AddCasestudyState();
}

class _AddCasestudyState extends ConsumerState<AddCasestudy> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.caseStudy != null) {
      titleController.text = widget.caseStudy!.title;
      contentController.text = widget.caseStudy!.content;
    }
  }

  void onAdd() async {
    if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
      if (widget.caseStudy != null) {
        widget.caseStudy!
          ..title = titleController.text
          ..content = contentController.text;
      }

      final user = FirebaseAuth.instance.currentUser;

      final casestudy = widget.caseStudy ??
          CaseStudy(titleController.text, contentController.text, user!.uid,
              DateTime.now().toIso8601String());

      await ref
          .read(caseStudyRepoProvider)
          .AddCaseStudy(widget.project.id, widget.usecase.id, casestudy);
      // ignore: unused_result
      ref.refresh(caseStudyRepoProvider);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'enter the title'),
            maxLength: 100,
            controller: titleController,
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'content',
            ),
            controller: contentController,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              color: Colors.white,
            ),
            maxLines: null, // Allows for unlimited lines
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: onAdd,
                label: Text(widget.caseStudy != null ? 'Add' : 'Save'),
                icon: const Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
