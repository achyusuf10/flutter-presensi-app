import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/controller/drawer_controller.dart';
import 'package:presensi_app/themes/font_style.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerC = Get.put(CustomDrawerController());
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Obx(() => Text(
                  drawerC.nama.value,
                  style: boldStyleWhite.copyWith(fontSize: 16),
                )),
            accountEmail: Obx(() => Text(
                  drawerC.jabatan.value,
                  style: regStyleWhite.copyWith(fontSize: 14),
                )),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              'Beranda',
              style: regStyleBlack.copyWith(fontSize: 12),
            ),
            onTap: () => drawerC.toHome(),
          ),
          ListTile(
            leading: const Icon(
              Icons.not_accessible,
              color: Colors.black,
            ),
            title: Text(
              'Log Absensi',
              style: regStyleBlack.copyWith(fontSize: 12),
            ),
            onTap: () => drawerC.toLog(),
          )
        ],
      ),
    );
  }
}
