import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Klip Shop',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
