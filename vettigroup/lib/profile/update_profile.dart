import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vettigroup/config/palette.dart';
import 'package:vettigroup/model/user.dart';
import 'package:vettigroup/provider/user_provider.dart';
import 'package:vettigroup/utility/utility_methods.dart';
import 'package:vettigroup/widgets/loader.dart';
import 'package:vettigroup/widgets/photo_picker.dart';

// ignore: must_be_immutable
class UpdateProfile extends ConsumerStatefulWidget {
  UpdateProfile({super.key, required this.user});
  AppUser user;
  @override
  ConsumerState<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends ConsumerState<UpdateProfile> {
  String? gender;
  AppUser? user;
  final _formKey = GlobalKey<FormState>();
  var action = false;

  String username = '';
  String email = '';
  String phonenumber = '';
  String bio = '';

  @override
  void initState() {
    super.initState();
    user = widget.user;

    gender = user!.gender == 'other' ? 'Male' : user!.gender;
  }

  File? selectedImage;

  void selectImage(File image) {
    setState(() {
      selectedImage = image;
    });
  }

//ADD ProfilePic
  void addProfilePic() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => PhotoPicker(
        imagePicked: selectImage,
      ),
    );
  }

  void updateProfile() async {
    bool validation = _formKey.currentState!.validate();

    if (validation) {
      _formKey.currentState!.save();

      String? imageUrl = widget.user.profilePicture;
      if (selectedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('Profile Pictures')
            .child('${widget.user.userId}.jpg');

        await storageRef.putFile(selectedImage!);

        imageUrl = await storageRef.getDownloadURL();
      }

      AppUser user = AppUser(
          username: username,
          email: email,
          userId: widget.user.userId,
          profilePicture: imageUrl,
          phoneNumber: int.tryParse(phonenumber) ?? 0,
          gender: gender!,
          bio: bio,
          connecting: widget.user.connecting,
          connections: widget.user.connections);

      try {
        ref.watch(userRepoProvider).updateUser(user);
        ref.invalidate(singleUserSnapshot(widget.user.userId));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        Text(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                  radius: 60,
                  child: Stack(
                    children: [
                      ClipOval(
                        child: selectedImage == null
                            ? widget.user.profilePicture == ''
                                ? Image.asset(
                                    'assets/gifs/profile.gif',
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 120,
                                  )
                                : Image.network(
                                    widget.user.profilePicture,
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                    width: double.infinity,
                                  )
                            : InkWell(
                                onTap: addProfilePic,
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: CircleAvatar(
                          backgroundColor: Palette.vettiGroupColor,
                          radius: 15,
                          child: IconButton(
                            onPressed: addProfilePic,
                            icon: const Icon(Icons.add),
                            iconSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: user!.username,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Username',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) => validateUsername(value!),
                      onSaved: (value) => username = value!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        enabled: false,
                        initialValue: user!.email,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.teal.shade400,
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) => validateEmail(value!),
                        onSaved: (value) => email = value!),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: user!.phoneNumber
                          .toString(), // Use '0' as the fallback if phoneNumber is null

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Phone Number',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => validatePhoneNumber(value!),
                      onSaved: (value) => phonenumber = value!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              gender = 'Male';
                            });
                          },
                          label: const Text('Male'),
                          icon: Icon(Icons.male,
                              size: gender == 'Male' ? 40 : 20,
                              color: gender == 'Male'
                                  ? Palette.online.withOpacity(0.5)
                                  : Palette.vettiGroupColor),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              gender = 'Female';
                            });
                          },
                          label: const Text('Female'),
                          icon: Icon(Icons.female,
                              size: gender == 'Female' ? 40 : 20,
                              color: gender == 'Female'
                                  ? Palette.online.withOpacity(0.5)
                                  : Palette.vettiGroupColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: user!.bio,
                      maxLines: 2,
                      maxLength: 50,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Bio',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      onSaved: (value) => bio = value!,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (action == false)
                          ElevatedButton.icon(
                              onPressed: () {
                                updateProfile();
                                setState(() {
                                  action = !action;
                                });
                              },
                              label: const Text('Save')),
                        if (action == false)
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Back')),
                        if (action == true) const Loader(type: 2)
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
