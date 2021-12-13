import 'package:flutter/material.dart';
import 'package:presensi_app/themes/font_style.dart';

class AlertDialogNotif extends StatelessWidget {
  final String title;
  final String srcImages;
  const AlertDialogNotif({
    required this.title,
    required this.srcImages,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: mediumStyleBlack.copyWith(fontSize: 19),
      ),
      content: Image.asset(
        srcImages,
        height: 74,
        width: 74,
      ),
    );
  }
}
