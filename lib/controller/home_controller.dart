import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:presensi_app/api/firebase_api.dart';
import 'package:presensi_app/common/routes.dart';
import 'package:presensi_app/model/attedance.dart';
import 'package:presensi_app/model/user_profile.dart';
import 'package:presensi_app/util/utils.dart';
import 'package:presensi_app/widget/alert_dialog_choice.dart';
import 'package:location/location.dart';
import 'package:presensi_app/widget/alert_dialog_notif.dart';
import 'package:presensi_app/widget/loading_screen.dart';

class HomeController extends GetxController {
  List<String> workCode = ['WFO', 'WFH'];
  var selectedWorkCode = "WFO".obs;
  onChangeGender(var value) {
    selectedWorkCode.value = value;
  }

  void logout() {
    Get.dialog(
      AlertDialogChoice(
        title: 'Log Out',
        desc: 'Apakah anda yakin untuk keluar ?',
        positiveBtnText: 'Ya',
        negativeBtnText: 'Tidak',
        onTapPositiveBtn: () async {
          await FirebaseAuth.instance.signOut();
          Get.offAllNamed(AppRoute.loginRoute);
        },
      ),
    );
  }

  void presensiNow() {
    Get.dialog(
      AlertDialogChoice(
        title: 'Presensi',
        desc: 'Apakah anda yakin untuk presensi sekarang ?',
        positiveBtnText: 'Datang',
        negativeBtnText: 'Pulang',
        onTapPositiveBtn: () {
          functionPresensi(true);
        },
        onTapNegativeBtn: () {
          functionPresensi(false);
        },
      ),
    );
  }

  void functionPresensi(bool isDatang) async {
    Get.dialog(const LoadingScreen(), barrierDismissible: false);
    GeoPoint dataLocation = await location.getLocation().then((value) {
      return GeoPoint(value.latitude!, value.longitude!);
    });
    bool onAreaWFH = await Utils.onAreaWFH(dataLocation);
    bool onAreaWFO = await Utils.onAreaWFO(dataLocation);
    bool isWFO = selectedWorkCode.value == 'WFO';
    bool success = false;
    String title = '';
    if (isDatang) {
      if (Utils.onTimeDatang(DateTime.now())) {
        if (isWFO) {
          (onAreaWFO)
              ? {title = 'Presensi Datang WFO Diterima', success = true}
              : title = 'Anda Terlalu Jauh Dari Area';
        } else {
          (onAreaWFH)
              ? {title = 'Presensi Datang WFH Diterima', success = true}
              : title = 'Anda Diluar Kota Anda';
        }
      } else {
        title = 'Anda Tidak Tepat Waktu';
      }
    }
    if (!isDatang) {
      if (Utils.onTimeDatang(DateTime.now())) {
        if (isWFO) {
          (onAreaWFO)
              ? {title = 'Presensi Pulang WFO Diterima', success = true}
              : title = 'Anda Terlalu Jauh Dari Area';
        } else {
          (onAreaWFH)
              ? {title = 'Presensi Pulang WFH Diterima', success = true}
              : title = 'Anda Diluar Kota Anda';
        }
      } else {
        title = 'Anda Tidak Tepat Waktu';
      }
    }
    var dataPresensi = Attedance(
        idUser: FirebaseAPI.getUserID() ?? '',
        isWFO: isWFO,
        isDatang: isDatang,
        createdTime: DateTime.now(),
        onArea: (isWFO) ? onAreaWFO : onAreaWFH,
        onTime: (isDatang)
            ? Utils.onTimeDatang(DateTime.now())
            : Utils.onTimePulang(DateTime.now()),
        geoPoint: dataLocation);
    await FirebaseAPI.createAttedance(dataPresensi);
    Get.back(closeOverlays: true);
    Get.dialog(
      AlertDialogNotif(
        title: title,
        srcImages: (success)
            ? 'assets/images/notif_succes.png'
            : 'assets/images/notif_failed.png',
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    Get.back(closeOverlays: true);
  }

  Location location = Location();
  final StreamController<GeoPoint> _locationStreamController =
      StreamController<GeoPoint>();
  Stream<GeoPoint> get locationStream => _locationStreamController.stream;
  void locationService() {
    location.requestPermission().then(
      (permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          location.onLocationChanged.listen((locationData) {
            if (locationData != null) {
              _locationStreamController.add(
                  GeoPoint(locationData.latitude!, locationData.longitude!));
            }
          });
        } else {
          locationService();
        }
      },
    );
  }

  double latitudeKantor = 0;
  double longitudeKantor = 0;
  @override
  void onInit() async {
    latitudeKantor = 0;
    longitudeKantor = 0;
    DocumentSnapshot docData = await FirebaseAPI.getUserProfile();
    UserProfile userProfile =
        UserProfile.fromJson(docData.data() as Map<String, dynamic>);
    latitudeKantor = userProfile.geoPointWFO.latitude;
    longitudeKantor = userProfile.geoPointWFO.longitude;

    Future.delayed(const Duration(seconds: 1)).then((_) => locationService());
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
