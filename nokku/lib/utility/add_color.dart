import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/color.dart';
import 'package:nokku/provider/repo_provider.dart';

// ignore: must_be_immutable
class AddChosenColors extends ConsumerStatefulWidget {
  AddChosenColors({super.key, required this.addNewcolor});

  void Function(ChosenColor color) addNewcolor;

  @override
  ConsumerState<AddChosenColors> createState() => _AddChosenColorsState();
}

class _AddChosenColorsState extends ConsumerState<AddChosenColors> {
  final redController = TextEditingController();
  final greenController = TextEditingController();
  final blueController = TextEditingController();

  @override
  void dispose() {
    redController.dispose();
    greenController.dispose();
    blueController.dispose();

    super.dispose();
  }

  void AddChosenColors() async {
    if (blueController.text.isNotEmpty &&
        redController.text.isNotEmpty &&
        greenController.text.isNotEmpty) {
      final repo = ref.read(colorRepoProvider);
      repo.addColor(
        ChosenColor(
          int.parse(redController.text),
          int.parse(greenController.text),
          int.parse(blueController.text),
        ),
      );
      // ignore: unused_result
      ref.refresh(chosenColorListProvider);

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
            controller: redController,
            decoration: InputDecoration(
              hintText: 'red',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: greenController,
            decoration: InputDecoration(
              hintText: 'green',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
            ),
            controller: blueController,
            decoration: InputDecoration(
              hintText: 'blue',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(
            width: 8), // Add some spacing between the TextField and the button
        TextButton.icon(
          onPressed: AddChosenColors,
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
