import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:fandomex/screens/dc.dart';
import 'package:fandomex/screens/home_page.dart';
import 'package:fandomex/screens/marvel.dart';
import 'package:flutter/material.dart';

class MyPages extends StatefulWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  State<MyPages> createState() => _MyPagesState();
}

class _MyPagesState extends State<MyPages> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 1);

  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    const MarvelPage(),
    const TheHomePage(),
    const DcPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: const Color.fromRGBO(24, 26, 32, 0.8),
              showLabel: false,
              notchColor: const Color.fromRGBO(24, 26, 32, 0.8),
              bottomBarItems:  const[
                BottomBarItem(
                  inActiveItem: Image(image: AssetImage('assets/Marvel1.png')),
                  activeItem: Image(image: AssetImage('assets/Marvel.png')),
                  itemLabel: 'Marvel Dome', 
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  activeItem: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 226, 18, 33),
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Image(image: AssetImage('assets/DC1.png')),
                  activeItem: Image(image: AssetImage('assets/DC.png')),
                  itemLabel: 'DC Dome',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
