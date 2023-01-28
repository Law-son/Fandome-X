import 'package:email_validator/email_validator.dart';
import 'package:fandomex/auth_pages/Utils.dart';
import 'package:fandomex/auth_pages/login_page.dart';
import 'package:fandomex/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignupPage extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignupPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return; 

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12.h),
                  child: Image.asset(
                    'assets/signup_bg.png',
                    width: 60.w,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 138, 138, 138),
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Please enter a valid email'
                            : null,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: Colors.white,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 138, 138, 138),
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 8
                        ? 'Minimum password length is 8'
                        : null,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 3),
                  width: 85.w,
                  height: 7.h,
                  child: ElevatedButton(
                    onPressed: signUp,
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
                    child: const Text('Signup'),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(fontSize: 13.sp, color: Colors.white),
                  ),
                  TextButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 226, 18, 33)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(onClickedSignUp: toggle)),
                      );
                    },
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
