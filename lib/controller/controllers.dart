import 'package:servefirst_admin/controller/SharedPreferencesController.dart';
import 'package:servefirst_admin/view/dashboard/controller/dashboard_controller.dart';
import 'package:servefirst_admin/view/edit_profile/controller/edit_profile_controller.dart';
import 'package:servefirst_admin/view/location/controller/location_controller.dart';
import 'package:servefirst_admin/view/login/controller/login_controller.dart';
import 'package:servefirst_admin/view/profile/controller/profile_controller.dart';
import 'package:servefirst_admin/view/report/controller/report_controller.dart';
import 'package:servefirst_admin/view/response_details/controller/response_details_controller.dart';
import 'package:servefirst_admin/view/splash/controller/splash_controller.dart';
import 'package:servefirst_admin/view/survey/controller/survey_controller.dart';
import 'package:servefirst_admin/view/survey_responses/controller/survey_responses_controller.dart';
import 'package:servefirst_admin/view/surveys/controller/surveys_controller.dart';

// Shared Preferences GetStorage Controller
SharedPreferencesController sharedPreferencesController = SharedPreferencesController.instance;

DashboardController dashboardController = DashboardController.instance;
LoginController loginController = LoginController.instance;
ReportController reportController = ReportController.instance;
ProfileController profileController = ProfileController.instance;
EditProfileController editProfileController = EditProfileController.instance;
SurveysController surveysController = SurveysController.instance;
// SurveyController surveyController = SurveyController.instance;
LocationController locationController = LocationController.instance;
SurveyResponsesController surveyResponsesController = SurveyResponsesController.instance;
ResponseDetailsController responseDetailsController = ResponseDetailsController.instance;
SplashController splashController = SplashController.instance;