// import 'package:fandomex/auth_pages/landing_page.dart';
// ignore_for_file: unused_local_variable
import 'package:fandomex/admob_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:fandomex/screens/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:fandomex/auth_pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'auth_pages/Utils.dart';
import 'palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AdmobService.initialize();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Fandome X',
        theme: ThemeData(
            primarySwatch: Palette.kToDark,
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 226, 18, 33),
                ),
              ),
            )),
        home: const Home(),
      );
    });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  static const String oneSignalAppId = "a52b08aa-9d57-4a15-a9b5-824342406f9e";
  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Something went wrong',
                  style: TextStyle(color: Colors.red, fontSize: 20)));
        } else if (snapshot.hasData) {
          return const MyPages();
        } else {
          return const AuthPage();
        }
      },
    ));
  }
}
