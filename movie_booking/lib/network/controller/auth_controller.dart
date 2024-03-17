import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/screens/auth/login_screen.dart';
import 'package:movie_booking/screens/home/home.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  bool isLoging = false;
  User? get user => _user.value;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, loginRedirect);
  }

  loginRedirect(User? user) {
    Timer(const Duration(seconds: 2), () {
      if (user == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    });
  }

  void registerUser(email, password) async {
    try {
      isLoading(true);
      update();
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      getSuccessSnackBar("Successfully register in as ${_user.value!.email}");
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar(
        "Account Creating Faild",
        e,
      );
    } finally {
      isLoading(false);
      update();
    }
  }

  void login(email, password) async {
    try {
      isLoging = true;
      isLoading(true);
      update();
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnackBar(
        "Login Failed",
        e,
      );
    } finally {
      isLoading(false);
      update();
    }
  }

  void forgorPassword(email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      getSuccessSnackBar(
        "Reset mail sent successfully. Check mail!",
      );
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar(
        "Error",
        e,
      );
    }
  }

  void googleLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    isLoging = true;
    isLoading(true);
    update();
    try {
      googleSignIn.disconnect();
      // ignore: empty_catches
    } catch (e) {}
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final crendentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(crendentials);
        getSuccessSnackBar("Successfully logged in as ${_user.value!.email}");
      }
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar("Google Login Failed", e);
    } on PlatformException catch (e) {
      getErrorSnackBar("Google Login Failed", e);
    } finally {
      isLoading(false);
      update();
    }
  }

  getErrorSnackBar(String message, _) {
    Get.snackbar(
      "Error",
      "$message\n${_.message}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(
        255,
        235,
        47,
        47,
      ),
      colorText: UIColors.white,
      borderRadius: 10,
    );
  }

  getSuccessSnackBar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: UIColors.greenColor,
      colorText: UIColors.white,
      borderRadius: 10,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
    );
  }

  void signOut() async {
    await auth.signOut();
  }
}
