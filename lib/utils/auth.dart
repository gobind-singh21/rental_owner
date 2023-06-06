import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/global.dart';
// import 'package:rental_owner/models/user_class.dart';
import 'package:rental_owner/screens/home_screen.dart';
// import 'package:rental_owner/screens/login_screen.dart';

class Auth {
  void setUserData(
      {required String name,
      required String email,
      required String number,
      required String profileImageURL}) {
    OwnerData.email = email;
    OwnerData.name = name;
    OwnerData.number = number;
    OwnerData.profileImageURL = profileImageURL;
    OwnerData.ownerDataSet = true;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final docRef = db.collection('owners').doc(userCredential.user!.uid);
      final doc = await docRef.get();
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        currentFirebaseUser = fAuth.currentUser;
        profileImagePath =
            'owners/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
        Fluttertoast.showToast(msg: 'Login successful');
        setUserData(
          name: data['name'],
          email: data['email'],
          number: data['number'],
          profileImageURL: data['profileImageURL'],
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'No record found',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String number,
    required File? pickedFile,
    required BuildContext context,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      currentFirebaseUser = fAuth.currentUser;
      profileImagePath =
          'owners/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
      final path = profileImagePath;
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(pickedFile!);
      final snapshot = await uploadTask.whenComplete(() {});
      final profileImageURL = await snapshot.ref.getDownloadURL();
      Fluttertoast.showToast(msg: 'created');
      final owners = db.collection('owners');
      final userData = <String, dynamic>{
        'id': userCredential.user!.uid,
        'email': email,
        'name': name,
        'number': number,
        'profileImageURL': profileImageURL,
        'productIDs': FieldValue.arrayUnion([]),
      };
      await owners.doc(userCredential.user!.uid).set(userData);
      setUserData(
        name: name,
        email: email,
        number: number,
        profileImageURL: profileImageURL,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  Future<void> updateUserInformation({
    required String email,
    required String name,
    required String number,
    required String oldImageUrl,
    File? profileImage,
  }) async {
    String profileImageURL = oldImageUrl;
    if (profileImage != null) {
      final String path = profileImagePath;
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(profileImage);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      profileImageURL = urlDownload;
    }
    try {
      await currentUser?.updateEmail(email);
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        toastLength: Toast.LENGTH_LONG,
      );
    }
    DocumentReference docRef = db.collection('owners').doc(currentUser!.uid);
    final userData = <String, dynamic>{
      'id': currentUser!.uid,
      'email': email,
      'name': name,
      'number': number,
      'profileImageURL': profileImageURL,
    };
    await docRef.update(userData);

    setUserData(
      name: name,
      email: email,
      number: number,
      profileImageURL: profileImageURL,
    );
    Fluttertoast.showToast(msg: 'Profile updated successfully!');
  }
}
