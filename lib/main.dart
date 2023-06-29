import 'package:flutter/material.dart';
import 'package:rental_owner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/global/global.dart';
import 'package:rental_owner/screens/login_screen.dart';
import 'package:rental_owner/screens/home_screen.dart';
import 'package:rental_owner/theme_provider.dart';
import 'package:rental_owner/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:rental_owner/pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(preferences!),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    currentFirebaseUser = fAuth.currentUser;
    Dimensions.screenHeight = MediaQuery.of(context).size.height;
    Dimensions.screenWidth = MediaQuery.of(context).size.width;
    return Consumer<ThemeProvider>(
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: value.currentThemeMode == ThemeModeType.light
              ? ThemeMode.light
              : ThemeMode.dark,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: (currentFirebaseUser == null)
              ? const LoginScreen()
              : const HomeScreen(),
        );
      },
    );
  }
}
