import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/common/routes.dart';
import 'package:presensi_app/widget/alert_dialog_notif.dart';
import 'package:presensi_app/widget/loading_screen.dart';

class LoginController extends GetxController {
  final formLoginKey = GlobalKey<FormState>();
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<void> login() async {
    Get.dialog(const LoadingScreen(), barrierDismissible: false);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameC.text, password: passwordC.text);
      Get.dialog(const AlertDialogNotif(
          title: 'Login Succes', srcImages: 'assets/images/notif_succes.png'));
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoute.homeRoute);
    } on FirebaseAuthException catch (e) {
      Get.back(closeOverlays: true);
      if (e.code == 'user-not-found') {
        Get.dialog(const AlertDialogNotif(
            title: 'User Not Found',
            srcImages: 'assets/images/notif_failed.png'));
        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      } else if (e.code == 'wrong-password') {
        Get.dialog(const AlertDialogNotif(
            title: 'Wrong Password',
            srcImages: 'assets/images/notif_failed.png'));

        await Future.delayed(const Duration(seconds: 1));
        Get.back(closeOverlays: true);
      }
    }
  }
}
