import 'package:flutter/material.dart';
import 'package:nokku/authentication/login_widgets.dart';
import 'package:nokku/authentication/wave_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: size.width < 600
          ? Stack(
              children: [
                // Background Color Container
                Container(
                  width: double.infinity,
                  height: size.height,
                  color: const Color(0xff4c505b),
                ),
                // Animated Wave Widget
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutQuad,
                  top: keyboardOpen ? -size.height / 3.7 : 0.0,
                  child: WaveWidget(
                    size: size,
                    yOffset: size.height / 3.0,
                    color: Colors.white,
                  ),
                ),
                // Form and Content
                const LoginWidget(),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xff4c505b),
                                      const Color(0xff4c505b).withOpacity(0.6),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)),
                            width: size.width * 0.5,
                            height: double.infinity,
                          ),
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutQuad,
                          top: 0.0,
                          child: WaveWidget(
                            size: size,
                            yOffset: size.height / 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
