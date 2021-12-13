import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presensi_app/model/attedance.dart';
import 'package:presensi_app/util/utils.dart';

class FirebaseAPI {
  static String? getUserID() {
    User? user = FirebaseAuth.instance.currentUser;
    return (user == null) ? null : user.uid;
  }

  static Future<void> createAttedance(Attedance attedance) async {
    final docAttedance =
        FirebaseFirestore.instance.collection('attedance').doc();
    attedance.id = docAttedance.id;
    await docAttedance.set(attedance.toMap());
  }

  static Future<DocumentSnapshot> getUserProfile() async {
    return FirebaseFirestore.instance.collection('user').doc(getUserID()).get();
  }

  static Stream<List<Attedance>> readAttedance(DateTime selectedTime) {
    DateTime _start = DateTime(
      selectedTime.year,
      selectedTime.month,
      selectedTime.day,
      0,
      0,
    );
    DateTime _end = DateTime(
      selectedTime.year,
      selectedTime.month,
      selectedTime.day,
      23,
      59,
      59,
    );
    return FirebaseFirestore.instance
        .collection('attedance')
        .where('idUser', isEqualTo: FirebaseAPI.getUserID())
        .where('createdTime',
            isGreaterThanOrEqualTo: Utils.convertToJson(_start))
        .where('createdTime', isLessThanOrEqualTo: Utils.convertToJson(_end))
        .orderBy('createdTime', descending: true)
        .snapshots()
        .transform(Utils.transformer(Attedance.fromJson) as StreamTransformer<
            QuerySnapshot<Map<String, dynamic>>, List<Attedance>>);
  }
}
