import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/utility.dart';
import 'package:nokku/provider/repo_provider.dart';

// ignore: must_be_immutable
class AddLibrary extends ConsumerStatefulWidget {
  AddLibrary({super.key, this.utility});

  Utility? utility;

  @override
  ConsumerState<AddLibrary> createState() => _AddLibraryState();
}

class _AddLibraryState extends ConsumerState<AddLibrary> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final contentController = TextEditingController();
  LibType libType = LibType.package;

  @override
  void initState() {
    super.initState();

    if (widget.utility != null) {
      titleController.text = widget.utility!.title;
      descController.text = widget.utility!.description;
      contentController.text = widget.utility!.content;
      libType = widget.utility!.type;
    }
  }

  void onAdd() async {
    if (titleController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        descController.text.isNotEmpty) {
      if (widget.utility != null) {
        widget.utility!
          ..title = titleController.text
          ..content = contentController.text
          ..description = descController.text
          ..type = libType;
      }

      final user = FirebaseAuth.instance.currentUser;

      final utility = widget.utility ??
          Utility(
              titleController.text,
              descController.text,
              contentController.text,
              user!.uid,
              DateTime.now().toIso8601String(),
              libType);

      ref.read(utilityProvider).add(utility);

      // ignore: unused_result
      ref.refresh(utilityListProvider);
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
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'description',
            ),
            controller: descController,
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
            children: LibType.values
                .map(
                  (lType) => IconButton(
                    onPressed: () {
                      setState(() {
                        libType = lType;
                      });
                    },
                    icon: Icon(
                      libTypeIcons[lType],
                      size: libType == lType ? 50 : 30,
                      color: libType == lType
                          ? const Color.fromARGB(255, 215, 185, 21)
                          : Colors.white,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
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
                label: const Text('Add'),
                icon: const Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}
