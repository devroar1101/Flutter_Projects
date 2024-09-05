import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nokku/model/utility.dart';
import 'package:nokku/provider/repo_provider.dart';
import 'package:nokku/utility/add_library.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() {
    return _LibraryScreenState();
  }
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  LibType libType = LibType.package;

  void onClickFloatingButton(Utility? utility) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => FractionallySizedBox(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
          child: AddLibrary(
            utility: utility,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final utilityAsyncValue = ref.watch(utilityListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: LibType.values
                .map(
                  (lType) => IconButton(
                    onPressed: () {
                      setState(() {
                        libType = lType;
                      });
                    },
                    icon: Icon(libTypeIcons[lType],
                        size: libType == lType ? 60 : 30,
                        color: libType == lType
                            ? Colors.lime
                            : Theme.of(context).colorScheme.primary),
                  ),
                )
                .toList(),
          ),
        ),
        centerTitle: true,
      ),
      body: utilityAsyncValue.when(
        data: (utilities) {
          // Filter the utilities based on the selected libType
          final filteredList =
              utilities.where((u) => u.type == libType).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: filteredList.length,
            itemBuilder: (ctx, index) {
              final sUtility = filteredList[index];
              return InkWell(
                onLongPress: () {
                  onClickFloatingButton(sUtility);
                },
                child: ExpansionTile(
                  leading: Icon(
                    libTypeIcons[sUtility.type],
                    size: 50,
                  ),
                  title: Text(
                    sUtility.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    sUtility.description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  tilePadding: const EdgeInsets.only(left: 20),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        sUtility.content,
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
          );
        },
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
