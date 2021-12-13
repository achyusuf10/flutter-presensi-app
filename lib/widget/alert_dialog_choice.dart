import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';

class AlertDialogChoice extends StatelessWidget {
  String title;
  String desc;
  String positiveBtnText;
  String negativeBtnText;
  VoidCallback onTapPositiveBtn;
  VoidCallback? onTapNegativeBtn;
  AlertDialogChoice({
    required this.title,
    required this.desc,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onTapPositiveBtn,
    this.onTapNegativeBtn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(
        title,
        style: mediumStyleBlack.copyWith(fontSize: 19),
      ),
      content: Text(
        desc,
        style: regStyle.copyWith(
          fontSize: 13,
          color: const Color(0xff828282),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: (onTapNegativeBtn != null)
                ? onTapNegativeBtn
                : () => Get.back(closeOverlays: true),
            child: Text(
              negativeBtnText,
              style: regStyleBlack.copyWith(fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: lightYellowColor,
            ),
          ),
        ),
        SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: onTapPositiveBtn,
            child: Text(
              positiveBtnText,
              style: regStyleWhite.copyWith(fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: lightBlueColor,
            ),
          ),
        )
      ],
    );
  }
}
