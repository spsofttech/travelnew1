import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelnew_app/views/edit_prima_screen/prima_trip_1to4_screen.dart';
import 'package:travelnew_app/views/home/home_screen.dart';

import 'package:travelnew_app/views/start/on_boarding_screen.dart';
import 'package:travelnew_app/views/start/sign_up_screen.dart';
import 'package:travelnew_app/widget/my_bottom_navbar.dart';

import 'views/edit_prima_screen/edit_prima_trip_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          //scaffoldBackgroundColor: const Color.fromRGBO(50, 50, 50, 0.8),
          fontFamily: GoogleFonts.roboto().fontFamily),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            } else if (user.hasData) {
              return MyBottomBar();
            } else {
              return OnBoardingScreen();
            }
          }),
    );
  }
}
