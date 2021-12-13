import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';

class CardDate extends StatelessWidget {
  const CardDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: darkBlueColor, width: 1.5),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/date.png',
                height: 85,
              ),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Text(
                        DateFormat('HH : mm').format(DateTime.now()),
                        style: semBoldStyle.copyWith(
                            fontSize: 48, color: darkBlueColor),
                      ),
                      Text(
                        DateFormat('EEEE, dd MMMM y').format(DateTime.now()),
                        style: regStyle.copyWith(
                            fontSize: 14, color: darkBlueColor),
                      )
                    ],
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
