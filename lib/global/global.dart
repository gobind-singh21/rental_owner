import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
String profileImagePath = "";
