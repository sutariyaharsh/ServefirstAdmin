import 'package:get/get.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/view/splash/splash_binding.dart';
import 'package:servefirst_admin/view/splash/splash_screen.dart';

class AppPage {
  static var list = [
    GetPage(name: AppRoute.splash, page: () => const SplashScreen(), binding: SplashBinding()),
  ];
}
