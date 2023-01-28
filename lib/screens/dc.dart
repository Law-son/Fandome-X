import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fandomex/admob_service.dart';
import 'package:fandomex/pages/home_page/home_page.dart';
import 'package:fandomex/screens/aboutApp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sizer/sizer.dart';

class DcPage extends StatefulWidget {
  const DcPage({super.key});

  @override
  State<DcPage> createState() => _DcPageState();
}

//carousel image list
List<String> imgList1 = [
  'assets/car1.jpg',
  'assets/car2.png',
  'assets/car1.jpg',
  'assets/car2.png',
  'assets/car1.jpg',
];

//movie ranking image list
List<String> ranking1 = [
  'assets/upcoming1.jpg',
  'assets/upcoming2.jpg',
  'assets/upcoming1.jpg',
  'assets/upcoming2.jpg',
  'assets/upcoming1.jpg',
];
const int maxFailedLoadAttempts = 3;

class _DcPageState extends State<DcPage> {
  final CollectionReference dcPage =
      FirebaseFirestore.instance.collection('dcPage');

  int _interstitialLoadAttempts = 0;
  InterstitialAd? _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdmobService.interstitialAdUnitId2,
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
        title: Text(
          'DC Dome',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: dcPage.get(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text(
                "Error. You're not connected to an internet connection",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                  children: snapshot.data!.docs.map((document) {
                ranking1 = [
                  '${document['dcUpc1']}',
                  '${document['dcUpc2']}',
                  '${document['dcUpc3']}',
                  '${document['dcUpc4']}',
                  '${document['dcUpc5']}',
                ];
                imgList1 = [
                  '${document['dcTrend1']}',
                  '${document['dcTrend2']}',
                  '${document['dcTrend3']}',
                  '${document['dcTrend4']}',
                  '${document['dcTrend5']}',
                ];
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: 95.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                '${document['dcHeroImage']}',
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 17, bottom: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'Trending DC Movies',
                          style: TextStyle(
                              fontSize: 17.sp,
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
                              Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            width: 45.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(imgList1[index]),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      // //Ads
                      // Container(
                      //   margin: const EdgeInsets.only(top: 5, bottom: 5),
                      //   height: 50,
                      //   child: AdWidget(
                      //     ad: AdmobService.createBannerAd2()..load(),
                      //     key: UniqueKey(),
                      //   ),
                      // ),
                      Container(
                        margin: const EdgeInsets.only(top: 17, bottom: 10),
                        alignment: Alignment.center,
                        child: Text(
                          'Upcoming DC Movies',
                          style: TextStyle(
                              fontSize: 17.sp,
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
                              Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            width: 45.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(ranking1[index]),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      //Ads
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        height: 50,
                        child: AdWidget(
                          ad: AdmobService.createBannerAd2()..load(),
                          key: UniqueKey(),
                        ),
                      ),
                      Container(
                          width: 95.w,
                          height: 15.h,
                          margin: const EdgeInsets.only(top: 12, bottom: 75),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            child: Container(
                              width: 85.w,
                              height: 10.h,
                              margin: const EdgeInsets.only(top: 5, bottom: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 226, 18, 33),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                'Explore DC Characters',
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
                  )),
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
            )),
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
