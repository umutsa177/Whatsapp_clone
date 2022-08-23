import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.cyan[400],
        textTheme: GoogleFonts.squarePegTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(backgroundColor: Colors.cyanAccent.shade400),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
