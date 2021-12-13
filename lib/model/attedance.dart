import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presensi_app/util/utils.dart';

class Attedance {
  String? id;
  String idUser;
  bool isDatang;
  DateTime createdTime;
  bool onArea;
  bool onTime;
  GeoPoint geoPoint;
  bool isWFO;
  Attedance({
    this.id,
    required this.idUser,
    required this.isWFO,
    required this.isDatang,
    required this.createdTime,
    required this.onArea,
    required this.onTime,
    required this.geoPoint,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'isDatang': isDatang,
      'createdTime': Utils.convertToJson(createdTime),
      'onArea': onArea,
      'onTime': onTime,
      'geoPoint': geoPoint,
      'isWFO': isWFO,
    };
  }

  static Attedance fromJson(Map<String, dynamic> json) {
    return Attedance(
      id: json['id'],
      idUser: json['idUser'],
      isDatang: json['isDatang'],
      createdTime: Utils.convertFromJson(json['createdTime']),
      onArea: json['onArea'],
      onTime: json['onTime'],
      geoPoint: json['geoPoint'],
      isWFO: json['isWFO'],
    );
  }
}
