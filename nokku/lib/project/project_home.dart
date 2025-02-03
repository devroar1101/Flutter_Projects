import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/color.dart';
import 'package:nokku/model/project.dart';
import 'package:nokku/project/add_project.dart';

import 'package:nokku/provider/repo_provider.dart';
import 'package:nokku/usecase/usecase_list.dart';
import 'package:nokku/utility/utility_home.dart';

class ProjectHome extends ConsumerStatefulWidget {
  const ProjectHome({super.key});

  @override
  ConsumerState<ProjectHome> createState() {
    return _ProjectHomeState();
  }
}

class _ProjectHomeState extends ConsumerState<ProjectHome> {
  final Random _random = Random();

  void onClickFloatingButtons({Project? project}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: 100,
            child: AddProject(
              project: project,
            ),
          ),
        );
      },
    );
  }

  void pickColor(int red, int green, int blue) {
    final repo = ref.read(colorRepoProvider);
    repo.addColor(ChosenColor(red, green, blue));
    // ignore: unused_result
    ref.refresh(chosenColorListProvider);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('color picked'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projectListAsyncValue = ref.watch(projectListProvider);

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => UtilityHome(),
                ),
              );
            },
            icon: const Icon(Icons.warehouse_rounded),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              } else if (value == 'profile') {
                // Navigate to profile page
                Navigator.pushNamed(context, '/profile');
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Profile', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice.toLowerCase(),
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const CircleAvatar(
              child: Icon(
                Icons.account_circle,
              ),
            ),
          ),
        ],
      ),
      body: projectListAsyncValue.when(
        data: (projects) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: width >= 850
                ? 4
                : width <= 600
                    ? 1
                    : 2,
            childAspectRatio: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(5),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            // final red = _random.nextInt(256);
            // final green = _random.nextInt(256);
            // final blue = _random.nextInt(256);
            final red = 164;
            final green = 78;
            final blue = 66;

            return InkWell(
              splashColor: Color.fromARGB(186, red, green, blue),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => UseCaseList(project: project),
                  ),
                );
              },
              onLongPress: () {
                onClickFloatingButtons(project: project);
              },
              onDoubleTap: () {
                pickColor(red, green, blue);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, red, green, blue),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onClickFloatingButtons,
        child: const Icon(Icons.add),
      ),
    );
  }
}
