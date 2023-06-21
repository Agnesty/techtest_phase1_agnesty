import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techtest_phase1_agnesty/resources/constants.dart';
import 'package:techtest_phase1_agnesty/routes/app_pages.dart';
import 'package:techtest_phase1_agnesty/screens/login_screen.dart';
// import 'package:techtest_phase1_agnesty/screens/session2.dart';
import 'package:techtest_phase1_agnesty/services/session.dart';
// import 'package:techtest_phase1_agnesty/dataUploader/data_uploader_screen.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

import 'bindings/binding.dart';
import 'screens/session_screen.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Session session = Session(enableLoginPage: true);

  StreamController streamController = StreamController();

  void redirectToLoginPage(BuildContext context) {
    GetStorage storage = GetStorage();
    bool pCounter = storage.read('pauseCounter');
    if (globalNavigatorKey.currentContext != null && pCounter == true) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (cxt) => AlertDialog(
          title: const Text(
            "Session Expired",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Silakan lakukan login kembali"),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await firebaseAuth.signOut();

                  storage.write('pauseCounter', false);
                  // bool pauseCounter = storage.read('pauseCounter');
                  // print("nilai pauseCounter di logout : $pauseCounter");

                  Get.offAll(LoginScreen());
                },
                child: const Text("Logout"))
          ],
        ),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (globalNavigatorKey.currentContext != null) {
      session.startListener(
          streamController: streamController,
          context: globalNavigatorKey.currentContext!);
    }

    return ConnectivityAppWrapper(
      app: SessionManager(
        onSessionExpired: () {
          if (globalNavigatorKey.currentContext != null &&
              session.enableLoginPage == true) {
            print('session expired');
            redirectToLoginPage(globalNavigatorKey.currentContext!);
          }
        },
        duration: const Duration(seconds: 10),
        streamController: streamController,
        child: GetMaterialApp(
          navigatorKey: globalNavigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: DataUploaderScreen(),
          initialBinding: InitialBinding(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: (buildContext, widget) {
            return ConnectivityWidgetWrapper(
              child: widget!,
              disableInteraction: true,
              height: 80,
            );
          },
        ),
      ),
    );
  }
}
