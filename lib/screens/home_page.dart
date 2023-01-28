import 'package:fandomex/admob_service.dart';
import 'package:fandomex/pages/home_page/home_page.dart';
import 'package:fandomex/screens/aboutApp.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';

class TheHomePage extends StatefulWidget {
  const TheHomePage({super.key});

  @override
  State<TheHomePage> createState() => _TheHomePageState();
}

//carousel image list
List<String> imgList = [
  'assets/car1.jpg',
  'assets/car2.png',
  'assets/car1.jpg',
  'assets/car2.png',
  'assets/car1.jpg',
];

//carousel image list
List<String> upcoming = [
  'assets/car1.jpg',
  'assets/car2.png',
  'assets/car1.jpg',
  'assets/car2.png',
  'assets/car1.jpg',
];

//movie ranking image list
List<String> ranking = [
  'assets/upcoming1.jpg',
  'assets/upcoming2.jpg',
  'assets/upcoming1.jpg',
  'assets/upcoming2.jpg',
  'assets/upcoming1.jpg',
];

int rankNumber = ranking.length;

//Carousel list map
final List<Widget> imageSliders = imgList
    .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                item,
                fit: BoxFit.cover,
                width: 100.w,
              )),
        ))
    .toList();

const int maxFailedLoadAttempts = 3;

class _TheHomePageState extends State<TheHomePage> {
  final CollectionReference homePage =
      FirebaseFirestore.instance.collection('homePage');

  int _interstitialLoadAttempts = 0;
  InterstitialAd? _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdmobService.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
  if (_interstitialAd != null) {
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
         ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
         _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
  }
}

  @override
  void initState() {
    super.initState();

    _createInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 26, 32, 1),
      //appBar
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: const Color.fromRGBO(24, 26, 32, 1),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              size: 25.sp,
              color: const Color.fromARGB(255, 226, 18, 33),
            ),
          );
        }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fandome ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
              ),
            ),
            Text(
              'X',
              style: TextStyle(
                color: const Color.fromARGB(255, 226, 18, 33),
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot<Object?>>(
          future: homePage.get(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                "Error. You're not connected to the internet",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                  children: snapshot.data!.docs.map((document) {
                imgList = [
                  '${document['carousel1']}',
                  '${document['carousel2']}',
                  '${document['carousel3']}',
                  '${document['carousel4']}',
                  '${document['carousel5']}',
                ];
                upcoming = [
                  '${document['upcoming1']}',
                  '${document['upcoming2']}',
                  '${document['upcoming3']}',
                  '${document['upcoming4']}',
                  '${document['upcoming5']}',
                ];
                ranking = [
                  '${document['top1']}',
                  '${document['top2']}',
                  '${document['top3']}',
                  '${document['top4']}',
                  '${document['top5']}',
                ];
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      children: [
                        //Carousel
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.vertical,
                            autoPlay: true,
                          ),
                          items: imageSliders,
                        ),
                        //Upcoming movies
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Upcoming Movies',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 30.h,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              width: 45.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(upcoming[index]),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        //Ads
                        // Container(
                        //   margin: const EdgeInsets.only(top: 5, bottom: 5),
                        //   height: 50,
                        //   child: AdWidget(
                        //     ad: AdmobService.createBannerAd()..load(),
                        //     key: UniqueKey(),
                        //   ),
                        // ),
                        //Updates
                        Container(
                          margin: const EdgeInsets.only(top: 17),
                          alignment: Alignment.center,
                          child: Text(
                            'Updates',
                            style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 75.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('${document['update']}'),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        //Fun Facts
                        Container(
                          margin: const EdgeInsets.only(top: 17),
                          alignment: Alignment.center,
                          child: Text(
                            'Fun Facts',
                            style: TextStyle(
                                fontSize: 17.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          width: 75.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage('${document['factImage']}'),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Did You Know?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 10),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${document['factText']}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        //Ads
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          height: 50,
                          child: AdWidget(
                            ad: AdmobService.createBannerAd()..load(),
                            key: UniqueKey(),
                          ),
                        ),
                        //Top Rankings
                        Container(
                          margin: const EdgeInsets.only(top: 17, bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            'Top Movie Ranking',
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) =>
                                Stack(children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                width: 45.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(ranking[index]),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                  left: 5.w,
                                  top: 1.h,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 226, 18, 33),
                                    radius: 10.sp,
                                    child: Text(
                                      '${rankNumber - index}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ))
                            ]),
                          ),
                        ),
                        //Ads
                        // Container(
                        //   margin: const EdgeInsets.only(top: 5, bottom: 5),
                        //   height: 50,
                        //   child: AdWidget(
                        //     ad: AdmobService.createBannerAd()..load(),
                        //     key: UniqueKey(),
                        //   ),
                        // ),
                        Container(
                          margin: const EdgeInsets.only(top: 17),
                          alignment: Alignment.center,
                        ),
                        Container(
                            width: 95.w,
                            height: 15.h,
                            margin: const EdgeInsets.only(top: 17, bottom: 75),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20)),
                            child: GestureDetector(
                              child: Container(
                                width: 85.w,
                                height: 10.h,
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 226, 18, 33),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'Explore Marvel/DC Characters',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              onTap: () {
                                _showInterstitialAd();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              },
                            ))
                      ],
                    ),
                  ),
                );
              }).toList());
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          })),
      drawer: Drawer(
        width: 87.w,
        backgroundColor: const Color.fromRGBO(24, 26, 32, 1),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 226, 18, 33),
                radius: 35.sp,
                child: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(24, 26, 32, 1),
                  radius: 48.sp,
                  child: Image.asset(
                    'assets/avatar.png',
                    width: 85.w,
                    height: 85.h,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 22.sp,
                  color: const Color.fromARGB(255, 226, 18, 33),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 27.sp,
                color: Colors.grey,
              ),
              title: Text(
                user.email!,
                softWrap: true,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.link,
                size: 27.sp,
                color: Colors.grey,
              ),
              title: Text(
                'Explore Marvel/DC Characters',
                style: TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
              onTap: () {
                _showInterstitialAd();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.phone_android,
                size: 27.sp,
                color: Colors.grey,
              ),
              title: Text(
                'About App',
                style: TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutApp()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: 27.sp,
                color: Colors.grey,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 11.sp, color: Colors.grey),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
