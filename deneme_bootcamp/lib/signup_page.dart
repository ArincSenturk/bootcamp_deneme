import 'package:deneme_bootcamp/signup_screen.dart';
import 'package:flutter/material.dart';

import 'vet_signup.screen.dart';

enum Option { Option1, Option2 }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Option selectedOption = Option.Option1;

  Widget getOption1Content() {
    return SingleChildScrollView(
    child: RegisterPage(),
  );
  }

  Widget getOption2Content() {
    return  VetRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (selectedOption == Option.Option1) {
      content = getOption1Content();
    } else {
      content = getOption2Content();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedOption = Option.Option1;
                      });
                    },
                    child: const Text('Üye Ol',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                    
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedOption = Option.Option2;
                      });
                    },
                    child: const Text(
                      'Veterinerim',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                      ),
                      ),
                  ),
                ),
              ],
            ),
            content,
          ],
        ),
      ),
    );
  }
}