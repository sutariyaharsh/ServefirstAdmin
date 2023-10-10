import 'package:get/get.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/view/dashboard/dashboard_binding.dart';
import 'package:servefirst_admin/view/dashboard/dashboard_screen.dart';
import 'package:servefirst_admin/view/edit_profile/edit_profile_binding.dart';
import 'package:servefirst_admin/view/edit_profile/edit_profile_screen.dart';
import 'package:servefirst_admin/view/location/location_binding.dart';
import 'package:servefirst_admin/view/location/location_screen.dart';
import 'package:servefirst_admin/view/login/login_binding.dart';
import 'package:servefirst_admin/view/login/login_screen.dart';
import 'package:servefirst_admin/view/response_details/response_details_binding.dart';
import 'package:servefirst_admin/view/response_details/response_details_screen.dart';
import 'package:servefirst_admin/view/splash/splash_binding.dart';
import 'package:servefirst_admin/view/splash/splash_screen.dart';
import 'package:servefirst_admin/view/survey_responses/survey_responses_binding.dart';
import 'package:servefirst_admin/view/survey_responses/survey_responses_screen.dart';
import 'package:servefirst_admin/view/surveys/surveys_screen.dart';
import 'package:servefirst_admin/view/surveys/survyes_binding.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding()
    ),
    GetPage(
        name: AppRoute.login,
        page: () => const LoginScreen(),
        binding: LoginBinding()
    ),
    GetPage(
        name: AppRoute.edit_profile,
        page: () => const EditProfileScreen(),
        binding: EditProfileBinding()
    ),
    GetPage(
        name: AppRoute.surveys,
        page: () => const SurveysScreen(),
        binding: SurveysBinding()
    ),
    GetPage(
        name: AppRoute.survey_responses,
        page: () => const SurveyResponsesScreen(),
        binding: SurveyResponsesBinding()
    ),
    GetPage(
        name: AppRoute.response_details,
        page: () => const ResponseDetailsScreen(),
        binding: ResponseDetailsBinding()
    ),
    GetPage(
        name: AppRoute.splash,
        page: () => const SplashScreen(),
        binding: SplashBinding()
    ),
    GetPage(
        name: AppRoute.location,
        page: () => const LocationScreen(),
        binding: LocationBinding()
    ),
  ];
}