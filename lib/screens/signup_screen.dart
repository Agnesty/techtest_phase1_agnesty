import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:techtest_phase1_agnesty/resources/constants.dart';
import 'package:techtest_phase1_agnesty/services/session.dart';

import '../controllers/auth_ctr.dart';
import '../services/encryption.dart';
import '../widgets/text_input_field.dart';
import 'login_screen.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  static String routeName = "/signupscreen";
  Session? session;
  SignUpScreen({this.session, super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authController = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _saveFormSignup() async {
    final isValid = formKey.currentState!.validate();
    FocusManager.instance.primaryFocus?.unfocus();
    if (!isValid) {
      print("Form validation failed!");
      Get.snackbar(
        'Failed Register',
        'Form validation failed!',
        duration: const Duration(seconds: 2),
      );
      return;
    }
    formKey.currentState!.save();

    if (widget.session != null) {
      widget.session!.enableLoginPage = true;
    }
    try {
      String passEncrypt = _passwordController.text.trim();
      var encryptedPassword =
          (await MyEncryption.encryptAES(passEncrypt)).base64;
      print("Password: $passEncrypt");
      print("Encrypted Password: $encryptedPassword");
      authController.registerUser(_usernameController.text.trim(),
          _emailController.text.trim(), encryptedPassword);
    } catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('An error occured!'),
                content: Text('Something went wrong! $e'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: Get.width * 0.4,
                  height: Get.width * 0.4,
                  child: LottieBuilder.network(
                      "https://assets7.lottiefiles.com/packages/lf20_zw0djhar.json"),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _usernameController,
                    icon: Icons.person,
                    labelText: 'Username',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'Minimum 4 characters required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailController,
                    icon: Icons.email,
                    labelText: 'Email',
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!regExForEmail.hasMatch(value!)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    labelText: 'Password',
                    isObsecure: true,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Minimum 6 characters required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorManager.buttonColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: InkWell(
                    onTap: _saveFormSignup,
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: ColorManager.TextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(LoginScreen());
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
