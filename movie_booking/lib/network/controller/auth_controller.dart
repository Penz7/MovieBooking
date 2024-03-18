// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_booking/generated/colors.gen.dart';
import 'package:movie_booking/router/app_router.dart';

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
        AppRouter.shareInstance.router.go('/login');
      } else {
        AppRouter.shareInstance.router.go('/home');
      }
    });
  }

  void login(BuildContext context, String email, String password) async {
    try {
      isLoging = true;
      isLoading(true);
      update();
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      getSuccessSnackBar(
          context, "Successfully logged in as ${_user.value!.email}");
    } on FirebaseAuthException catch (e) {
      //define error
      getErrorSnackBar(context, "Login Failed", e);
    } finally {
      isLoading(false);
      update();
    }
  }

  void registerUser(BuildContext context, String email, String password) async {
    try {
      isLoading(true);
      update();
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      getSuccessSnackBar(context, "Successfully register in as $email");
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar(context, "Account Creating Failed", e);
    } finally {
      isLoading(false);
      update();
    }
  }

  void forgotPassword(BuildContext context, String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      getSuccessSnackBar(context, "Reset mail sent successfully. Check mail!");
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar(context, "Error", e);
    }
  }

  void googleLogin(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    isLoging = true;
    isLoading(true);
    update();
    try {
      googleSignIn.disconnect();
    } catch (e) {
      // ignore: empty_catches
    }
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credentials);
        getSuccessSnackBar(
            context, "Successfully logged in as ${_user.value!.email}");
      }
    } on FirebaseAuthException catch (e) {
      getErrorSnackBar(context, "Google Login Failed", e);
    } on PlatformException catch (e) {
      getErrorSnackBar(context, "Google Login Failed", e as FirebaseAuthException);
    } finally {
      isLoading(false);
      update();
    }
  }

  void getErrorSnackBar(
      BuildContext context, String message, FirebaseAuthException e) {
    final snackBar = SnackBar(
      content: Text("$message\n${e.message}"),
      backgroundColor: const Color.fromARGB(
        255,
        235,
        47,
        47,
      ),
      duration: const Duration(
        seconds: 1,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: UIColors.greenColor,
      duration: const Duration(
        seconds: 1,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void signOut() async {
    await auth.signOut();
  }
}
