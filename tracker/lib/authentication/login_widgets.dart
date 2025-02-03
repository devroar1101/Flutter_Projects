import 'package:tracker/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';

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
  final passwordController = TextEditingController();

  String? validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateUsername(String value) {
    if (!islogin) {
      if (value.isEmpty) {
        return 'Username cannot be empty';
      } else if (value.length < 3) {
        return 'Username must be at least 3 characters long';
      }
      return null;
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

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
              userId: userauth.user!.uid,
              profilePicture: '',
              role: 'Admin');

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
      bottom: keyboardOpen ? 10 : 118,
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
                  baseColor: Colors.black87,
                  highlightColor: Colors.white,
                  child: Text(
                    islogin ? 'Login' : 'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (!islogin)
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.teal.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.teal.shade400),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) => validateUsername(value!),
                  ),
                if (!islogin) const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.teal.shade400),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => validateEmail(value!),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.teal.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.teal.shade400),
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  validator: (value) => validatePassword(value!),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: authentication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    islogin ? 'Sign In' : 'Sign Up',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: sendPasswordResetEmail,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
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
