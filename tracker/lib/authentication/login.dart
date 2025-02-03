import 'dart:ui';

import 'package:tracker/authentication/login_widgets.dart';

import 'package:flutter/material.dart';
import 'package:tracker/config.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Configuration.appcolor,
      body: size.width < 750
          ? Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Image.asset(
                    'assest/compass.gif',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width > 600 ? 450 : 300,
                  ),
                ),
                // Background Color Container
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Animated Wave Widget

                // Form and Content
                const LoginWidget(),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Image.asset(
                        'assest/compass.gif',
                        fit: BoxFit.contain,
                        height:
                            MediaQuery.of(context).size.width > 600 ? 450 : 300,
                      ),
                    ),
                  ),
                ),

                // Form and Content
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 50, right: 20),
                  child: LoginWidget(),
                )),
              ],
            ),
    );
  }
}
