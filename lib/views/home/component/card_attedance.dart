import 'package:flutter/material.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';

class CardAttedance extends StatelessWidget {
  const CardAttedance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: lightYellowColor, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Waktu Presensi',
            style: semBoldStyle.copyWith(fontSize: 22, color: darkBlueColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Jam Masuk',
                style: regStyle.copyWith(fontSize: 18, color: darkBlueColor),
              ),
              Text(
                '06:30 - 07:30',
                style: regStyle.copyWith(fontSize: 18, color: darkBlueColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Jam Keluar',
                style: regStyle.copyWith(fontSize: 18, color: darkBlueColor),
              ),
              Text(
                '16:00 - 20:00',
                style: regStyle.copyWith(fontSize: 18, color: darkBlueColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
