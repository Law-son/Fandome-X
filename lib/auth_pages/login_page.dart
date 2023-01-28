import 'package:fandomex/auth_pages/forgotPassword.dart';
import 'package:fandomex/auth_pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fandomex/main.dart';
import 'Utils.dart';

class LoginPage extends StatefulWidget {
  final Function() onClickedSignUp;
  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      //print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(24, 26, 32, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                child: Image.asset(
                  'assets/login_bg.png',
                  width: 55.w,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  style: const TextStyle(color: Color.fromARGB(255, 138, 138, 138),),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 138, 138, 138),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp),
                    focusColor: const Color.fromARGB(255, 226, 18, 33),
                    prefixIcon: const Icon(
                      Icons.person,
                      size: 25,
                      color: Color.fromARGB(255, 138, 138, 138),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  controller: passwordController,
                  style: const TextStyle(color: Color.fromARGB(255, 138, 138, 138),),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 138, 138, 138),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp),
                    focusColor: const Color.fromARGB(255, 138, 138, 138),
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 25,
                      color: Color.fromARGB(255, 138, 138, 138),
                    ),
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 226, 18, 33)),
                ),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  const ForgotPassword()),
                        );
                },
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                width: 85.w,
                height: 7.h,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 226, 18, 33),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0.sp)),
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal),
                  ),
                  child: const Text('Login'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 13.sp, color: Colors.white),
                ),
                TextButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 226, 18, 33)),
                  ),
                  onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>   SignupPage(onClickedSignIn: toggle)),
                        );
                      },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
