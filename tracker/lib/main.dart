import 'package:flutter/material.dart';
import 'package:tracker/expense_widgets/home.dart';
//import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //(fn) =>
  runApp(
    MaterialApp(
      home: ExpenseHome(),
    ),
  );
  //);
}
