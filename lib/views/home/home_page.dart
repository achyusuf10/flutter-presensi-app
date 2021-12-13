import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/controller/home_controller.dart';

import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/views/home/component/card_attedance.dart';
import 'package:presensi_app/views/home/component/card_date.dart';
import 'package:presensi_app/views/home/component/radio_work_code.dart';
import 'package:presensi_app/widget/custom_button.dart';
import 'package:presensi_app/widget/custom_drawer.dart';

import 'component/card_maps.dart';
import 'component/card_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomeController());
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: lightBlueColor,
        centerTitle: true,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        actions: [
          IconButton(
            onPressed: () => homeC.logout(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CardUser(),
            const CardDate(),
            const CardAttedance(),
            const RadioWorkCode(),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              buttonName: 'PRESENSI SEKARANG',
              colorText: Colors.white,
              colorBG: lightBlueColor,
              onTap: () {
                homeC.presensiNow();
              },
              margin: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const CardMaps(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
