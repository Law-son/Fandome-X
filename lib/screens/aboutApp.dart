// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

const String _linkedIn =
    'https://www.linkedin.com/in/lawson-buabassah-792b34225/';
const String _whatsapp = 'https://wa.me/233272001700';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  final CollectionReference aboutApp =
      FirebaseFirestore.instance.collection('aboutApp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'About App',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(24, 26, 32, 1),
      body: FutureBuilder<QuerySnapshot>(
          future: aboutApp.get(),
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
                return SingleChildScrollView(
                    child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 90.w,
                        height: 40.h,
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 23.sp,
                                    backgroundColor:
                                        const Color.fromRGBO(24, 26, 32, 1),
                                    child: CircleAvatar(
                                      radius: 21.sp,
                                      backgroundImage: NetworkImage(
                                          '${document['devImage']}'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lawson Buabassah',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(
                                                24, 26, 32, 1),
                                          ),
                                        ),
                                        Text(
                                          'Developer',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w300,
                                            color: const Color.fromRGBO(
                                                24, 26, 32, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 10,
                              color: Color.fromRGBO(24, 26, 32, 1),
                            ),
                            ListTile(
                              leading: const Icon(Icons.mail,
                                  size: 23,
                                  color: Color.fromRGBO(24, 26, 32, 1)),
                              title: Text(
                                'buabassahlawson@gmail.com',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromRGBO(24, 26, 32, 1),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.phone,
                                  size: 23,
                                  color: Color.fromRGBO(24, 26, 32, 1)),
                              title: Text(
                                '+233 256 722 900',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: const Color.fromRGBO(24, 26, 32, 1),
                                ),
                              ),
                            ),
                            ListTile(
                                leading: const Icon(Icons.whatsapp,
                                    size: 23,
                                    color: Color.fromRGBO(24, 26, 32, 1)),
                                title: Text(
                                  '+233 272 001 700',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color.fromRGBO(24, 26, 32, 1),
                                  ),
                                ),
                                onTap: _linkURLS),
                            ListTile(
                                leading: Text(
                                  'in',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(24, 26, 32, 1),
                                  ),
                                ),
                                tileColor: const Color.fromRGBO(24, 26, 32, 1),
                                title: Text(
                                  'LinkedIn',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color.fromRGBO(24, 26, 32, 1),
                                  ),
                                ),
                                onTap: _linkURL)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Text(
                          'ABOUT THIS APP',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Text(
                          'Fandome X is a DC & Marvel fandome app. The sole purpose of this app is to provide users with relevant information regarding DC/Marvel movies and comics. App updates will be released monthly to ensure that users have the best experience. Credits: Leandro Aguierre ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 95),
                        child: Text(
                          'Version ${document['appVersion']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ));
              }).toList());
            }
            return const Center(child: CircularProgressIndicator(color: Colors.white,));
          })),
    );
  }

  void _linkURL() async {
    // ignore: deprecated_member_use
    if (!await launch(_linkedIn)) {
      throw 'Could not launch $_linkedIn';
    }
  }

  void _linkURLS() async {
    // ignore: deprecated_member_use
    if (!await launch(_whatsapp)) {
      throw 'Could not launch $_whatsapp';
    }
  }
}
