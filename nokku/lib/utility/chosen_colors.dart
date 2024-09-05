import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/color.dart';
import 'package:nokku/provider/repo_provider.dart';
import 'package:nokku/utility/add_color.dart';

class ChosenColors extends ConsumerStatefulWidget {
  const ChosenColors({super.key});

  @override
  ConsumerState<ChosenColors> createState() => _ChosenColorsState();
}

class _ChosenColorsState extends ConsumerState<ChosenColors> {
  List<ChosenColor> colors = [];

  void addColor(ChosenColor color) {
    setState(() {
      colors.add(color);
    });
  }

  void onClickFloatingButtons() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: 100,
          child: AddChosenColors(addNewcolor: addColor),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final chosenColorAsyncValue = ref.watch(chosenColorListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Colors'),
      ),
      body: chosenColorAsyncValue.when(
        data: (colors) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width >= 600 ? 6 : 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(5),
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final singleColor = colors[index];
            return FlipCard(
              direction: FlipDirection.HORIZONTAL,
              front: Card(
                elevation: 5,
                shadowColor: const Color.fromARGB(186, 255, 255, 255),
                color: Color.fromARGB(
                    255, singleColor.red, singleColor.green, singleColor.blue),
              ),
              back: Card(
                elevation: 5,
                shadowColor: const Color.fromARGB(186, 255, 255, 255),
                color: Color.fromARGB(
                    255, singleColor.red, singleColor.green, singleColor.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      '${singleColor.red}\n${singleColor.green}\n${singleColor.blue}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        error: (error, stackTrace) => SelectableText(
          error.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickFloatingButtons,
        child: const Icon(Icons.add),
      ),
    );
  }
}
