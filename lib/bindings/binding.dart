import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/controllers/auth_ctr.dart';
import 'package:techtest_phase1_agnesty/controllers/data_ctr.dart';
import 'package:techtest_phase1_agnesty/controllers/product_ctr.dart';
import 'package:techtest_phase1_agnesty/controllers/respon_ctr.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResponModelCtr());
    Get.lazyPut(() => DataModelCtr());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProductCtr());
  }
}
