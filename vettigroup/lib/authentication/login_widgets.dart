import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';

import 'package:vettigroup/model/user.dart';

import 'package:vettigroup/utility/utility_methods.dart';

final authInstance = FirebaseAuth.instance;

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginWidgetsState();
  }
}

class LoginWidgetsState extends State<LoginWidget> {
  bool islogin = true;
  final _form = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController =
      TextEditingController(); // Phone number controller
  final passwordController = TextEditingController();

  void authentication() async {
    final formIsValid = _form.currentState!.validate();

    if (formIsValid) {
      try {
        if (islogin) {
          await authInstance.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
        } else {
          final userauth = await authInstance.createUserWithEmailAndPassword(
              email: emailController.text.trim().toLowerCase(),
              password: passwordController.text);

          final AppUser user = AppUser(
              username: usernameController.text,
              email: emailController.text,
              phoneNumber: int.tryParse(phoneNumberController.text) ??
                  0, // Parsing phone number as integer
              userId: userauth.user!.uid,
              profilePicture: '',
              gender: 'other',
              bio: 'hi hello am new to Vgram',
              connections: [userauth.user!.uid],
              connecting: []);

          FireStoreUserRepositorty(FirebaseFirestore.instance).addUser(user);
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? 'Authentication failed'),
        ));
      }
    }
  }

  Future<void> sendPasswordResetEmail() async {
    final email = emailController.text.trim().toLowerCase();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent.'),
          ),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send password reset email: ${e.message}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an email address.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Positioned(
      bottom: keyboardOpen
          ? 5
          : !islogin
              ? 90
              : 60,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 4, 12, 0),
                  highlightColor: const Color.fromARGB(255, 211, 222, 166),
                  child: Text(
                    'Vgram',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lobster(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 255, 215, 0), // Gold
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (!islogin)
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Username',
                      hintStyle: GoogleFonts.poppins(
                        color: Palette.vettiGroupColor,
                        fontSize: 16,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        (!islogin) ? validateUsername(value!) : 'null',
                  ),
                if (!islogin) const SizedBox(height: 5),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                      color: Palette.vettiGroupColor,
                      fontSize: 16,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => validateEmail(value!),
                ),
                const SizedBox(height: 5),
                if (!islogin)
                  TextFormField(
                    controller: phoneNumberController, // Phone number field
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Phone Number',
                      hintStyle: GoogleFonts.poppins(
                        color: Palette.vettiGroupColor,
                        fontSize: 16,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => validatePhoneNumber(value!),
                  ),
                if (!islogin) const SizedBox(height: 5),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                      color: Palette.vettiGroupColor,
                      fontSize: 16,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => validatePassword(value!),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: authentication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 255, 215, 0), // Gold color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    islogin ? 'Sign In' : 'Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          islogin = !islogin;
                        });
                      },
                      child: Text(
                        islogin ? 'Create an Account' : 'Back to Sign In',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: sendPasswordResetEmail,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
