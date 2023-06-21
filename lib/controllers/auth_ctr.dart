import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/models/user_model.dart' as model;
import 'package:techtest_phase1_agnesty/routes/app_pages.dart';

import '../resources/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  Rx<User?> get user => _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.userChanges());
    // ever(_user, _setInitialScreen);
  }

  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(LoginScreen());
  //   } else {
  //     Get.offAll(const BottomNavigation());
  //   }
  // }

  // Register User
  Future<void> registerUser(
      String username, String email, String password) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // Save user data in Authentication and Firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //Menyimpan di getStorage
        final box = GetStorage();
        box.write('email', email);
        box.write('username', username);

        model.User user = model.User(
          username: username,
          email: email,
          uid: cred.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        Get.offAllNamed(Routes.BOTTOMNAV);
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  //Login User
  Future<void> loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        final user = firebaseAuth.currentUser;
        if (user != null) {
          final box = GetStorage();
          box.write('email', email);
          box.write('userId', user.uid);
        }

        Get.offAllNamed(Routes.BOTTOMNAV);
      } else {
        Get.snackbar(
          'Error logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  //Logout User
  Future<void> logout() async {
    GetStorage().remove('email');
    GetStorage().remove('userId');
    GetStorage().remove('username');
    // Logout dari sistem otentikasi FirebaseAuth
    await firebaseAuth.signOut();

    GetStorage storage = GetStorage();
    storage.write('pauseCounter', false);
    bool pauseCounter = storage.read('pauseCounter');
    print("nilai pauseCounter di logout : $pauseCounter");

    // Menampilkan notifikasi logout berhasil
    Get.snackbar(
      'Logout',
      'Logout berhasil',
      duration: const Duration(seconds: 2),
    );
  }
}
