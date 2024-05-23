import 'package:e_tablo/core/extensions.dart';
import 'package:e_tablo/firebase_options.dart';
import 'package:e_tablo/views/auth/signIn.dart';
import 'package:e_tablo/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Table',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            border: InputBorder.none,
            hintStyle:
                TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, fontSize: context.texts.bodyMedium?.fontSize)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null ? const HomeView() : const SignIn(),
    );
  }
}
