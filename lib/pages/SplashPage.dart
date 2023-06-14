import 'package:flutter/material.dart';
import 'package:tubes_klip/pages/LoginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                      parent: _animationController, curve: Curves.easeOut)),
              child: Image.asset('assets/images/logo.png',
                  width: 200, height: 100)),
          const SizedBox(height: 10),
          ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.linear,
            )),
            child: const Text('Selamat Datang di Klip',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          )
        ],
      )),
      bottomNavigationBar: const SizedBox(
          height: 40,
          child: Text('Pandawa Slebew',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))),
    );
  }
}
