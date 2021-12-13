import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:presensi_app/api/firebase_api.dart';
import 'package:presensi_app/model/user_profile.dart';

class Utils {
  static bool onTimeDatang(DateTime time) {
    final startTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      6,
      30,
    );
    final endTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      7,
      30,
    );
    if (time.isAfter(startTime) && time.isBefore(endTime)) return true;
    return false;
  }

  static bool onTimePulang(DateTime time) {
    final startTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      16,
      0,
    );
    final endTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      20,
      0,
    );
    if (time.isAfter(startTime) && time.isBefore(endTime)) return true;
    return false;
  }

  static Future<bool> onAreaWFO(GeoPoint geoPoint) async {
    DocumentSnapshot docData = await FirebaseAPI.getUserProfile();
    UserProfile userProfile =
        UserProfile.fromJson(docData.data() as Map<String, dynamic>);
    double distanceInMeter = Geolocator.distanceBetween(
        userProfile.geoPointWFO.latitude,
        userProfile.geoPointWFO.longitude,
        geoPoint.latitude,
        geoPoint.longitude);
    return (distanceInMeter <= 200) ? true : false;
  }

  static Future<bool> onAreaWFH(GeoPoint geoPoint) async {
    DocumentSnapshot docData = await FirebaseAPI.getUserProfile();
    UserProfile userProfile =
        UserProfile.fromJson(docData.data() as Map<String, dynamic>);
    String kota = userProfile.kota;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);

    Placemark place = placemarks[0];
    return (place.subAdministrativeArea!.contains(kota));
  }

  static DateTime convertFromJson(Timestamp value) {
    return value.toDate();
  }

  static dynamic convertToJson(DateTime value) {
    return value.toUtc();
  }

  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromMap) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          List<T>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> data,
            EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromMap(json)).toList();
          sink.add(objects);
        },
      );
}
