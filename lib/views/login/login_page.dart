import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/controller/login_controller.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';
import 'package:presensi_app/widget/custom_button.dart';
import 'package:presensi_app/widget/custom_text_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginC = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: loginC.formLoginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 70,
                    ),
                    Text(
                      'PRESENSI',
                      style: boldStyle.copyWith(
                        fontSize: 26,
                        color: darkBlueColor,
                      ),
                    ),
                    Text(
                      'ONLINE',
                      style: boldStyle.copyWith(
                        fontSize: 12,
                        color: greyColor,
                        letterSpacing: 5,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomTextForm(
                      controller: loginC.usernameC,
                      erorrText: 'Email Harus Diisi',
                      label: 'Masukkan Email Anda',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextForm(
                      controller: loginC.passwordC,
                      erorrText: 'Password Harus Diisi',
                      label: 'Masukan Password Anda',
                      obs: true,
                      needIconObs: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      buttonName: 'LOGIN',
                      colorBG: lightYellowColor,
                      onTap: () {
                        if (loginC.formLoginKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          loginC.login();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
