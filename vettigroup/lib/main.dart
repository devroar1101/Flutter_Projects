import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vettigroup/authentication/login.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/firebase_options.dart';
import 'package:vettigroup/nav_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // Add this line in your main function.

          theme: ThemeData(
              primarySwatch: Colors.cyan,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              scaffoldBackgroundColor: Palette.scaffold),
          home: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return const NavScreen();
          } else {
            return const LoginPage();
          }
        });
  }
}
