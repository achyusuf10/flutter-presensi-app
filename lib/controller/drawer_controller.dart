import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:presensi_app/api/firebase_api.dart';
import 'package:presensi_app/common/routes.dart';
import 'package:presensi_app/model/user_profile.dart';

class CustomDrawerController extends GetxController {
  void toHome() {
    if (Get.currentRoute != AppRoute.homeRoute) {
      Get.offAllNamed(AppRoute.homeRoute);
    } else {
      Get.back(closeOverlays: true);
    }
  }

  void toLog() {
    if (Get.currentRoute != AppRoute.logRoute) {
      Get.offAllNamed(AppRoute.logRoute);
    } else {
      Get.back(closeOverlays: true);
    }
  }

  RxString nama = ''.obs;
  RxString jabatan = ''.obs;

  @override
  Future<void> onInit() async {
    DocumentSnapshot docData = await FirebaseAPI.getUserProfile();
    UserProfile userProfile =
        UserProfile.fromJson(docData.data() as Map<String, dynamic>);
    nama.value = userProfile.name;
    jabatan.value = userProfile.jabatan;
    super.onInit();
  }
}
