import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formshandling/models/groceryitem.dart';
import 'package:http/http.dart' as http;
import 'package:formshandling/models/categories.dart';
import 'package:formshandling/models/category.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddItemState();
  }
}

class AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int quantity = 1;
  Category selectedCategory = categories[Categories.fruit]!;
  bool isSaving = false;

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isSaving = true;
      });

      final url = Uri.https(
          'flutter-prep-1234-udmey-default-rtdb.firebaseio.com',
          'gorcery-item.json');

      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: json.encode(
          {
            'name': name,
            'quantity': quantity,
            'category': selectedCategory.type,
          },
        ),
      );

      if (!context.mounted) {
        return;
      }

      final responseBody = jsonDecode(response.body);

      Navigator.pop(
          context,
          GroceryItem(
              id: responseBody['name'],
              name: name,
              quantity: quantity,
              category: selectedCategory));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Name must between 1 and 50 ';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: '1',
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Quantity must be greater than 0 ';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        quantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: selectedCategory,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(category.value.type)
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        }),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: isSaving
                          ? null
                          : () {
                              _formKey.currentState!.reset();

                              setState(() {
                                selectedCategory =
                                    categories[Categories.fruit]!;
                              });
                            },
                      child: const Text('Reset')),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: _saveForm,
                      child: isSaving
                          ? const CircularProgressIndicator()
                          : const Text('Add Item')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
