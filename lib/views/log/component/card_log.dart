import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/model/attedance.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';

class CardLog extends StatelessWidget {
  final Attedance data;
  const CardLog({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool disetujui = (data.onArea && data.onTime);
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (data.isDatang)
            ? lightBlueColor.withOpacity(0.15)
            : lightYellowColor.withOpacity(0.15),
      ),
      child: Row(
        children: [
          Container(
            width: 13,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: (data.isDatang) ? lightBlueColor : lightYellowColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (data.isDatang) ? 'Datang' : 'Pulang',
                    style: boldStyle.copyWith(
                      color: (data.isDatang) ? darkBlueColor : darkYellowColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-y  HH:mm:ss').format(data.createdTime),
                    style: mediumStyleBlack.copyWith(fontSize: 14),
                  ),
                  Text(
                    (data.onArea) ? 'Dalam Kawasan' : 'Diluar Kawasan',
                    style: regStyleBlack.copyWith(fontSize: 14),
                  ),
                  Text(
                    (data.onTime) ? 'Tepat Waktu' : 'Telat',
                    style: regStyleBlack.copyWith(fontSize: 14),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      (disetujui) ? 'Disetujui' : 'Ditolak',
                      style: semBoldStyle.copyWith(
                          fontSize: 14,
                          color: (disetujui) ? greenColor : redColor,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
