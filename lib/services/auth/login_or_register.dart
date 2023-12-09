import 'package:chatapp/page/login.dart';
import 'package:chatapp/page/signup.dart';
import 'package:flutter/material.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool showLoginPage = true;
  void toogLepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(ontap: toogLepages);
    } else {
      return SignUp(
        onTap: toogLepages,
      );
    }
  }
}
