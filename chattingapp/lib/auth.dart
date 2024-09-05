import 'dart:io';

import 'package:chattingapp/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AuthScreenState();
  }
}

class AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  String enteredEmail = '';
  String enterdPassword = '';
  String enteredUsername = '';
  File? selectedImage;
  bool isAuthentication = false;
  bool isLogin = true;

  void onSubmit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid || (selectedImage == null && !isLogin)) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      isAuthentication = true;
    });

    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: enteredEmail, password: enterdPassword);
      } else {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: enteredEmail, password: enterdPassword);

        if (selectedImage != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('UserPictures')
              .child('${userCredential.user!.uid}.jpg');

          // Upload the file
          final uploadTask = storageRef.putFile(selectedImage!);

          // Wait for the upload to complete
          await uploadTask;

          // Get the download URL
          final imageUrl = await storageRef.getDownloadURL();

          // Save user information in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': enteredUsername,
            'imageUrl': imageUrl,
            'email': enteredEmail,
          });
        } else {
          // Save user information in Firestore without image URL
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': enteredUsername,
            'email': enteredEmail,
          });
        }

        setState(() {
          isAuthentication = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'An error occurred'),
        ),
      );
      setState(() {
        isAuthentication = false;
      });
    } catch (e) {
      // Handle other types of exceptions
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
        ),
      );
      setState(() {
        isAuthentication = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                child: Image.asset(
                  'assets/images/chat.png',
                  width: 200,
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _form,
                      child: Column(
                        children: [
                          if (!isLogin)
                            ImagePickerWidget(formImage: (pickedImage) {
                              selectedImage = pickedImage;
                            }),
                          const SizedBox(
                            height: 10,
                          ),
                          if (!isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'user name'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 4) {
                                  return 'Please enter a username with more than 4 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                if (value != null) {
                                  enteredUsername = value;
                                }
                              },
                            ),
                          const SizedBox(height: 10),
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'email'),
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                enteredEmail = value;
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 6) {
                                return isLogin
                                    ? 'Please enter a valid password'
                                    : 'Please enter a strong password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                enterdPassword = value;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (isAuthentication)
                            const CircularProgressIndicator(),
                          if (!isAuthentication)
                            ElevatedButton(
                              onPressed: onSubmit,
                              style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.primary),
                              child: Text(isLogin ? 'Login' : 'Sign Up'),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (!isAuthentication)
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(isLogin
                                    ? 'Create new account'
                                    : 'Login with existing account'))
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
