import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/controllers/respon_ctr.dart';
import 'package:techtest_phase1_agnesty/screens/bottom_navigation.dart';
import 'package:techtest_phase1_agnesty/screens/edit_product_screen.dart';
import 'package:techtest_phase1_agnesty/screens/signup_screen.dart';
import '../controllers/auth_ctr.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: BindingsBuilder(
        () {
          Get.put(AuthController());
        },
      ),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpScreen(),
      binding: BindingsBuilder(
        () {
          Get.put(AuthController());
        },
      ),
    ),
    GetPage(
      name: _Paths.BOTTOMNAV,
      page: () => const BottomNavigation(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: BindingsBuilder(
        () {
          Get.put(ResponModelCtr());
        },
      ),
    ),
    GetPage(
      name: _Paths.EDITPRODUCT,
      page: () => EditProductScreen(),
    ),
  ];
}
