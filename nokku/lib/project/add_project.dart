import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nokku/model/project.dart';

import 'package:nokku/provider/repo_provider.dart';

// ignore: must_be_immutable
class AddProject extends ConsumerStatefulWidget {
  AddProject({super.key, this.project});

  Project? project;

  @override
  ConsumerState<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends ConsumerState<AddProject> {
  final textControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    textControl.text = widget.project?.title ?? '';
  }

  @override
  void dispose() {
    textControl.dispose();
    super.dispose();
  }

  void addProject() async {
    if (textControl.text.isNotEmpty) {
      final user = FirebaseAuth.instance.currentUser;
      final repo = ref.read(projectRepoProvider);
      if (widget.project == null) {
        widget.project = Project(
          textControl.text,
          user!.uid,
          DateTime.now().toIso8601String(),
        );
      } else {
        widget.project!.title = textControl.text;
      }

      await repo.addProject(widget.project!);

      // ignore: unused_result
      ref.refresh(projectListProvider);

      Navigator.pop(context);
    }
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
              hintText: 'Enter project name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(
            width: 8), // Add some spacing between the TextField and the button
        TextButton.icon(
          onPressed: addProject,
          label: Text(widget.project == null ? 'Add' : 'Save'),
          icon: const Icon(Icons.add),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
