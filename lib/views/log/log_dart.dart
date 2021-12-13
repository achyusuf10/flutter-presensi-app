import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:presensi_app/api/firebase_api.dart';
import 'package:presensi_app/model/attedance.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';
import 'package:presensi_app/views/log/component/card_log.dart';
import 'package:presensi_app/widget/custom_button.dart';
import 'package:presensi_app/widget/custom_drawer.dart';

class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  DateTime selectedDate = DateTime.now();
  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(DateTime.now().year - 5),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'Log Absensi',
          style: regStyleWhite.copyWith(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.green.withOpacity(0.2),
            child: Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  color: darkBlueColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  DateFormat('dd MMMM y').format(selectedDate),
                  style: regStyle.copyWith(fontSize: 14, color: darkBlueColor),
                ),
                const Spacer(),
                CustomButton(
                  buttonName: 'Pilih Tanggal',
                  customName: Text(
                    'Pilih Tanggal',
                    style:
                        lightStyle.copyWith(fontSize: 12, color: darkBlueColor),
                  ),
                  colorBG: Colors.white,
                  colorBorder: darkBlueColor,
                  width: 120,
                  height: 30,
                  onTap: () {
                    pickDate();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Attedance>>(
                stream: FirebaseAPI.readAttedance(selectedDate),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something Error, Try Again Later'),
                        );
                      } else {
                        if (snapshot.data!.isNotEmpty) {
                          return ListView.separated(
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            itemBuilder: (context, index) => CardLog(
                              data: snapshot.data![index],
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Data Masih Kosong'),
                          );
                        }
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}

List<Attedance> list = [
  Attedance(
    isWFO: true,
    isDatang: true,
    createdTime: DateTime.now(),
    onArea: true,
    onTime: true,
    idUser: '11',
    geoPoint: GeoPoint(0, 0),
  ),
];
