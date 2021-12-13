import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/controller/home_controller.dart';
import 'package:presensi_app/themes/font_style.dart';

class RadioWorkCode extends StatelessWidget {
  const RadioWorkCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Row(
      children: [
        Obx(
          () => Radio(
              value: homeC.workCode[0],
              groupValue: homeC.selectedWorkCode.value,
              onChanged: (val) {
                homeC.onChangeGender(val);
              }),
        ),
        Text(
          'WFO',
          style: regStyleBlack.copyWith(fontSize: 14),
        ),
        Obx(
          () => Radio(
              value: homeC.workCode[1],
              groupValue: homeC.selectedWorkCode.value,
              onChanged: (val) {
                homeC.onChangeGender(val);
              }),
        ),
        Text(
          'WFH',
          style: regStyleBlack.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
