import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  String name;
  String jabatan;
  GeoPoint geoPointWFO;
  String kota;
  UserProfile({
    required this.geoPointWFO,
    required this.kota,
    required this.name,
    required this.jabatan,
  });

  static UserProfile fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      jabatan: json['jabatan'],
      geoPointWFO: json['geoPointWFO'],
      kota: json['kota'],
    );
  }
}
