import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:doc_insight/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:string_extensions/string_extensions.dart';

class ProfileController with ChangeNotifier {
  //getting current user id
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final Utils utils = Utils();
  final textController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('Users');
  final currentUserEmail = FirebaseAuth.instance.currentUser!.email;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  // pick image from gallery
  Future pickGalleryImage(BuildContext context) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  //pick image from camera
  Future pickCameraImage(BuildContext context) async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedImage != null) {
      _image = XFile(pickedImage.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  //Show pick image options in UI
  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: color4LightGray.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Set Profile Image',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26.0,
                      letterSpacing: 1.0,
                      color: itemsColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 41.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/gallery.png',
                            width: 30.0,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/camera.png',
                            width: 30.0,
                            fit: BoxFit.cover,
                          ),
                          const Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // upload image to firebase database
  void uploadImage(BuildContext context) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('/profileImage/$currentUserId');
    firebase_storage.UploadTask uploadTask = ref.putFile(File(image!.path));

    await Future.value(uploadTask);
    final newUrl = await ref.getDownloadURL();
    firestore
        .doc(currentUserId)
        .update({'profileImage': newUrl.toString()}).then((value) {
      utils.toastMessage('Profile Updated', Colors.green);
      _image = null;
      notifyListeners();
    }).onError((error, stackTrace) {
      utils.toastMessage(error.toString(), Colors.red);
    });
  }

  //Show edit profile fields options in UI
  Future<void> editFields(context, String field) async {
    String fieldTitle = field.capitalize;
    String newValue = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              color: color4LightGray.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Edit $fieldTitle',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: itemsColor,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: textController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Edit your $field',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[500],
                          letterSpacing: 1.0,
                        ),
                        prefixIcon: IconButton(
                          icon: ImageIcon(
                            const AssetImage('assets/images/pen.png'),
                            color: itemsColor,
                          ),
                          onPressed: () {},
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onChanged: (value) {
                        newValue = value;
                      },
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text('Cancel',
                            style: TextStyle(color: itemsColor, fontSize: 20)),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 2),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: TextButton(
                          child: const Text('Save',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          onPressed: () => Navigator.of(context).pop(newValue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (newValue != "") {
      firestore.doc(currentUserId).update({field: newValue});
      textController.clear();
    }
  }
}
