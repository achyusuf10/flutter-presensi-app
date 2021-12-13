import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presensi_app/controller/home_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:presensi_app/themes/color.dart';
import 'package:presensi_app/themes/font_style.dart';
import 'package:presensi_app/widget/loading_screen.dart';
import 'dart:async';

class CardMaps extends StatefulWidget {
  const CardMaps({Key? key}) : super(key: key);

  @override
  State<CardMaps> createState() => _CardMapsState();
}

class _CardMapsState extends State<CardMaps> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffFFF9D9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: darkBlueColor, width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Info Lokasi',
            style: mediumStyleBlack.copyWith(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: darkBlueColor),
            ),
            child: StreamBuilder<GeoPoint>(
                stream: homeC.locationStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    CameraPosition _userPosition = CameraPosition(
                      target: LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      zoom: 14.4746,
                    );
                    Marker _marker = Marker(
                      markerId: const MarkerId('marker'),
                      infoWindow: const InfoWindow(title: 'Lokasi Anda'),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                    );
                    Marker _markerKantor = Marker(
                      markerId: const MarkerId('markerKantor'),
                      infoWindow: const InfoWindow(title: 'Kantor Anda'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue),
                      position:
                          LatLng(homeC.latitudeKantor, homeC.longitudeKantor),
                    );
                    Circle _areaKantor = Circle(
                      circleId: const CircleId('0'),
                      radius: 200,
                      center:
                          LatLng(homeC.latitudeKantor, homeC.longitudeKantor),
                      fillColor: darkBlueColor.withOpacity(0.3),
                      strokeWidth: 0,
                    );
                    return GoogleMap(
                      mapType: MapType.normal,
                      markers: {_marker, _markerKantor},
                      circles: {_areaKantor},
                      initialCameraPosition: _userPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    );
                  } else {
                    return const LoadingScreen();
                  }
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                color: const Color(0xffEC4137),
              ),
              Text(
                ' Lokasi Anda',
                style: regStyle.copyWith(fontSize: 12),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                height: 10,
                width: 10,
                color: const Color(0xff3436E8),
              ),
              Text(
                ' Lokasi Kantor Anda',
                style: regStyle.copyWith(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
