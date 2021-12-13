import 'package:get/get.dart';
import 'package:presensi_app/views/home/home_page.dart';
import 'package:presensi_app/views/log/log_dart.dart';
import 'package:presensi_app/views/login/login_page.dart';

class AppRoute {
  static const String homeRoute = '/home';
  static const String logRoute = '/logPage';
  static const String loginRoute = '/loginPage';

  static List<GetPage<dynamic>> route = [
    GetPage(
        name: homeRoute,
        page: () => const HomePage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 700)),
    GetPage(
        name: logRoute,
        page: () => const LogPage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 700)),
    GetPage(
        name: loginRoute,
        page: () => const LoginPage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(milliseconds: 700)),
  ];
}
