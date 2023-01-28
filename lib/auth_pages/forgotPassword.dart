// ignore_for_file: file_names

import 'package:fandomex/auth_pages/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  Future resetPassword() async {
  await FirebaseAuth.instance
  .sendPasswordResetEmail(email: emailController.text.toLowerCase());
  Utils.showSnackBar("Password reset mail has been sent.");
  }

  @override
  void dispose() {
    emailController.dispose();
    
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
              margin: const EdgeInsets.only(top: 150),
              child: Text(
                "Reset Your Password",
                style: TextStyle(
                  fontSize: 23.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/login_bg.png',
                width: 55.w,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: Text(
                "Please enter the registered email for your Fandome X account. A link will be sent to this email, open that link to reset your password. Check your spam mail in case you don't see the mail",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
                  margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    style: const TextStyle(color: Color.fromARGB(255, 138, 138, 138),),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                      hintText: "Enter your email",
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
                  margin: const EdgeInsets.only(top: 20),
                  width: 85.w,
                  height: 7.h,
                  child: ElevatedButton(
                    onPressed: resetPassword,
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
                    child: const Text('Reset Password'),
                  ),
                ),
                
          ],
        )),
      ),
    );
  }
}