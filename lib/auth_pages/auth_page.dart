import 'package:fandomex/auth_pages/landing_page.dart';
import 'package:fandomex/auth_pages/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
        ? LandingPage(onClickedSignUp: toggle)
        : SignupPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
