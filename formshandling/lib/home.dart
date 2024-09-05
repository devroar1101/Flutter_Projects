import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formshandling/AddItem.dart';
import 'package:formshandling/models/categories.dart';
import 'package:formshandling/models/dummydata.dart';
import 'package:formshandling/models/groceryitem.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GroceryItem> Items = [];
  bool dataLoading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('flutter-prep-1234-udmey-default-rtdb.firebaseio.com',
        'gorcery-item.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        error = 'No data fetch from database';
        dataLoading = false;
        return;
      });
    }

    if (response.body == 'null') {
      setState(() {
        error = 'No data found';
        dataLoading = false;
        return;
      });
    }
    final Map<String, dynamic> listItem = json.decode(response.body);

    final List<GroceryItem> loadedItem = [];

    for (final item in listItem.entries) {
      final category = categories.entries
          .firstWhere((catitem) => catitem.value.type == item.value['category'])
          .value;

      loadedItem.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }

    setState(() {
      Items = loadedItem;
      dataLoading = false;
    });
  }

  void onAddItem(BuildContext context) async {
    final newItem = await Navigator.push<GroceryItem>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const AddItem(),
      ),
    );

    if (newItem != null) {
      setState(() {
        Items.add(newItem);
        dataLoading = false;
        error = null;
      });
    }
  }

  void onRemove(GroceryItem item, int index) async {
    setState(() {
      Items.remove(item);
    });

    final url = Uri.https('flutter-prep-1234-udmey-default-rtdb.firebaseio.com',
        'gorcery-item/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      final index = groceryItems.indexOf(item);
      setState(() {
        groceryItems.insert(index, item);
      });
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item Removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () {
              Items.insert(index, item);

              http.patch(url,
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    'name': item.name,
                    'quantity': item.quantity,
                    'category': item.category.type,
                  }));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      padding: const EdgeInsets.all(60),
      itemCount: Items.length,
      itemBuilder: (context, index) {
        final item = Items[index];

        return Dismissible(
          key: ValueKey(item.id),
          onDismissed: (direction) {
            onRemove(item, index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
                width: 8,
                child: Container(
                  color: item.category.color,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                item.quantity.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (dataLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error != null) {
      content = Center(
        child: Text(error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: IconButton(
                onPressed: () {
                  onAddItem(context);
                },
                icon: const Icon(Icons.add)),
          ),
        ],
      ),
      body: content,
    );
  }
}
