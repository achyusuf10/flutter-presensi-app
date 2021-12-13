import 'package:flutter/material.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';

class CustomTextForm extends StatefulWidget {
  Function(String)? onChange;
  final TextEditingController? controller;
  bool obs;
  final String label;

  bool needIconObs;
  bool showError;
  String erorrText;
  bool defaultOnChange;

  CustomTextForm({
    this.onChange,
    this.defaultOnChange = true,
    this.erorrText = 'Harus Terisi',
    this.controller,
    this.obs = false,
    this.needIconObs = false,
    this.showError = false,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: lightYellowColor, width: 1)),
          height: 56,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: widget.controller,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        widget.showError = false;
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        widget.showError = true;
                      });
                      return '';
                    }
                    return null;
                  },
                  obscureText: widget.obs,
                  style: regStyleBlack.copyWith(fontSize: 15),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.label,
                    hintStyle: lightStyle.copyWith(fontSize: 15),
                    errorStyle: const TextStyle(height: 0),
                  ),
                ),
              ),
              Visibility(
                visible: widget.needIconObs,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obs = !widget.obs;
                    });
                  },
                  child: Icon(
                    (widget.obs)
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color(0xff828282),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.showError,
          child: Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Text(
              widget.erorrText,
              style: regStyle.copyWith(fontSize: 12, color: Colors.red),
            ),
          ),
        )
      ],
    );
  }
}
