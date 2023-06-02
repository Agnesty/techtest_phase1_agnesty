import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:techtest_phase1_agnesty/dataUploader/data_uploader_screen.dart';
import 'package:techtest_phase1_agnesty/screens/splash_screen.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';

import 'bindings/binding.dart';
import 'routes/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  InitialBinding().dependencies();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
        app: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: DataUploaderScreen(),
      initialRoute: SplashScreen.routeName,
      getPages: Routes.pages(),
      builder: (buildContext, widget) {
        return ConnectivityWidgetWrapper(
          child: widget!,
          disableInteraction: true,
          height: 80,
        );
      },
    ));
  }
}
