import 'dart:convert';

import 'package:dashboard/localized_texts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Filters extends StatefulWidget {
  const Filters({super.key, required this.langCode});

  final String langCode;

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  String? selectedName;
  String? selectedDepartment;
  String? selectedSection;
  List<dynamic>? dgData;
  bool loading = true;

  final List<String> names = ['Alice', 'Bob'];
  final List<String> departments = ['HR', 'IT'];
  final List<String> sections = ['Finance', 'Development'];

  Future<void> getDgdgData() async {
    final url = 'http://eofficetbdevdal.cloutics.net/api/DG/LookUpDG';

    final response = await http.get(Uri.parse(url), headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      setState(() {
        dgData = json.decode(response.body);
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
        print('${response.statusCode}');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDgdgData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: selectedName,
            hint: Text(LocalizedTexts.getText(widget.langCode, 'selectDg')),
            onChanged: (String? newValue) {
              setState(() {
                selectedName = newValue;
              });
            },
            items: dgData?.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item['nameEnglish'],
                child: Text(widget.langCode == 'en'
                    ? item['nameEnglish']
                    : item['nameArabic']),
              );
            }).toList(),
          ),
          const SizedBox(
            width: 20,
          ),
          DropdownButton<String>(
            value: selectedDepartment,
            hint: Text(
                LocalizedTexts.getText(widget.langCode, 'selectDepartment')),
            onChanged: (String? newValue) {
              setState(() {
                selectedDepartment = newValue;
              });
            },
            items: departments.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            width: 20,
          ),
          DropdownButton<String>(
            value: selectedSection,
            hint: Text(
                LocalizedTexts.getText(widget.langCode, 'selectDepartment')),
            onChanged: (String? newValue) {
              setState(() {
                selectedSection = newValue;
              });
            },
            items: sections.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DummydgDataWidget extends StatelessWidget {
  final String title;

  const DummydgDataWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
