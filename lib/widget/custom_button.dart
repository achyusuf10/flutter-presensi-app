import 'package:flutter/material.dart';
import 'package:presensi_app/themes/font_style.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  final Color colorBG;
  final Color colorText;
  final int margin;
  final Color? colorBorder;
  final double height;
  final double? width;
  final Widget? customName;
  const CustomButton(
      {required this.buttonName,
      this.customName,
      this.colorText = Colors.black,
      this.colorBorder,
      this.height = 58,
      this.width,
      required this.colorBG,
      required this.onTap,
      this.margin = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width != null)
          ? width
          : MediaQuery.of(context).size.width - 2 * margin,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        child: (customName == null)
            ? Text(
                buttonName,
                style: boldStyle.copyWith(fontSize: 18, color: colorText),
              )
            : customName,
        style: ElevatedButton.styleFrom(
          onPrimary: (colorBorder != null) ? colorBorder : Colors.white,
          primary: colorBG,
          shape: RoundedRectangleBorder(
            side: (colorBorder != null)
                ? BorderSide(color: colorBorder!)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(67),
          ),
        ),
      ),
    );
  }
}
