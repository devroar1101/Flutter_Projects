import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker/config.dart';
import 'package:tracker/model/entity_type.dart';
import 'entity_type_provider.dart'; // Import your provider file

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(entityTypeProvider);
    final notifier = ref.read(entityTypeProvider.notifier);

    final List<String> contries = ref.watch(contryProvider);

    print('1111$contries');

    // Automatically load entity types when the screen is built
    if (state.isLoading && state.entityTypes.isEmpty && state.error == null) {
      notifier.loadEntityTypes();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.error != null
                      ? Center(child: Text(state.error!))
                      : SizedBox(
                          width: 300,
                          height: 200,
                          child: ListView.builder(
                            itemCount: state.entityTypes.length,
                            itemBuilder: (context, index) {
                              final entityType = state.entityTypes[index];
                              return SizedBox(
                                height: 80, // Height for the card
                                child: Card(
                                  elevation: 4,
                                  color: Configuration
                                      .cardColor, // Change this to your desired color
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        entityType.type,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .white, // Change this to your desired text color
                                        ),
                                      ),
                                    ),
                                    onLongPress: () => _showEditBottomSheet(
                                        context, notifier, entityType),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => _showAddBottomSheet(context, notifier),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBottomSheet(BuildContext context, EntityTypeNotifier notifier) {
    final TextEditingController controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Entity Type'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final entityType = EntityType(controller.text, null);
                  notifier.addEntityType(entityType);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditBottomSheet(BuildContext context, EntityTypeNotifier notifier,
      EntityType entityType) {
    final TextEditingController controller =
        TextEditingController(text: entityType.type);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Entity Type'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final updatedEntityType =
                      EntityType(controller.text, entityType.id);
                  notifier.updateEntityType(updatedEntityType);
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }
}
