import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/controllers/responModel_ctr.dart';
import '../screens/data_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static List<GetPage> pages() => [
        GetPage(name: "/splashscreen", page: () => const SplashScreen()),
        GetPage(
          name: "/data",
          page: () => DataScreen(),
          binding: BindingsBuilder(
            () {
              Get.put(() => ResponModelCtr());
            },
          ),
        ),
      ];
}
