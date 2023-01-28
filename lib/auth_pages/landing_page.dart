import 'package:fandomex/auth_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LandingPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LandingPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}


class _LandingPageState extends State<LandingPage> {
  bool isLogin = true;
  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/landing_page_bg.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Welcome to Fandome X",
                    style: TextStyle(
                        fontSize: 23.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "The best Marvel & DC Fandome App",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 35, 0, 35),
                    width: 80.w,
                    height: 8.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>   LoginPage(onClickedSignUp: toggle,)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 226, 18, 33),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0.sp)),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal),
                      ),
                      child: const Text('Get Started'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
