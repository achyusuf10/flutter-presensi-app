import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presensi_app/api/firebase_api.dart';
import 'package:presensi_app/model/user_profile.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';
import 'package:presensi_app/widget/loading_screen.dart';

class CardUser extends StatelessWidget {
  const CardUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 140,
          color: Colors.white,
        ),
        Container(
          height: 70,
          color: lightBlueColor,
        ),
        Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  lightYellowColor,
                  Colors.white,
                ],
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(0, 1),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder<DocumentSnapshot>(
              future: FirebaseAPI.getUserProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                } else {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else {
                    UserProfile userProfile = UserProfile.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>);

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Selamat Datang',
                          style: semBoldStyleBlack.copyWith(fontSize: 18),
                        ),
                        Text(
                          userProfile.name,
                          style: semBoldStyle.copyWith(
                            fontSize: 22,
                            color: darkBlueColor,
                          ),
                        ),
                        Text(
                          userProfile.jabatan,
                          style: regStyle.copyWith(
                            fontSize: 16,
                            color: darkBlueColor,
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            )),
      ],
    );
  }
}
