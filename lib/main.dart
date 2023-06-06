import 'package:flutter/material.dart';
import 'package:rental_owner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/global/global.dart';
import 'package:rental_owner/screens/login_screen.dart';
import 'package:rental_owner/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    currentFirebaseUser = fAuth.currentUser;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primaryColor: Colors.blue,
        // fontFamily: GoogleFonts.lato().fontFamily,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: (currentFirebaseUser == null) ? const LoginScreen() : HomeScreen(),
    );
  }
}
