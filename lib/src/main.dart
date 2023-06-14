import 'package:flutter/material.dart';
import 'package:tubes_klip/pages/SplashPage.dart';
import 'package:tubes_klip/src/firebase_options.dart';
// import 'package:tubes_klip/pages/CheckoutPage.dart';
// import 'package:tubes_klip/pages/HomePage.dart';
import 'package:tubes_klip/pages/ProductDetailsPage.dart';
// import 'package:tubes_klip/pages/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
  FirebaseDatabase database = FirebaseDatabase.instance;
  database.databaseURL =
      'https://klip-56f41-default-rtdb.asia-southeast1.firebasedatabase.app/';
  final userRef = database.ref().child('users');
  await userRef.push().set({
    'name': 'Rafi',
    'email': 'rafiandeo@gmail.com',
    'password': '123456',
    'roles': 'admin',
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginPage(),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
