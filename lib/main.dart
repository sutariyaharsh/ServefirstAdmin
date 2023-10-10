import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:servefirst_admin/bindings/app_bindings.dart';
import 'package:servefirst_admin/model/local_response/save_survey_pojo.dart';
import 'package:servefirst_admin/model/request/survey_submit/image_names.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';
import 'package:servefirst_admin/model/response/location_survey/employee.dart';
import 'package:servefirst_admin/model/response/location_survey/location.dart';
import 'package:servefirst_admin/model/response/location_survey/location_survey_data.dart';
import 'package:servefirst_admin/model/response/location_survey/options.dart';
import 'package:servefirst_admin/model/response/location_survey/question.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/model/response/login/tour.dart';
import 'package:servefirst_admin/model/response/login/user.dart';
import 'package:servefirst_admin/model/response/response_list/answers.dart';
import 'package:servefirst_admin/model/response/response_list/responses_data.dart';
import 'package:servefirst_admin/model/response/response_list/survey_categories.dart';
import 'package:servefirst_admin/model/response/survey_dashboard/survey_dashboard_data.dart';
import 'package:servefirst_admin/route/app_page.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String colorCode =
      await fetchColorCodeFromBackend(); // Replace with your backend fetching logic
  Color newColor = Color(int.parse(colorCode, radix: 16)).withOpacity(1.0);
  AppTheme.updateLightPrimaryColor(newColor);
  await Hive.initFlutter();

  //register adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TourAdapter());
  Hive.registerAdapter(SurveyDashboardDataAdapter());
  Hive.registerAdapter(LocationSurveyDataAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(SurveyAdapter());
  Hive.registerAdapter(EmployeeAdapter());
  Hive.registerAdapter(QuestionsAdapter());
  Hive.registerAdapter(OptionsAdapter());
  Hive.registerAdapter(ResponsesDataAdapter());
  Hive.registerAdapter(SurveyCategoriesAdapter());
  Hive.registerAdapter(AnswersAdapter());
  Hive.registerAdapter(SaveSurveyPojoAdapter());
  Hive.registerAdapter(SurveySubmitJsonDataAdapter());
  Hive.registerAdapter(ImageNamesAdapter());

  configLoading();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => GetMaterialApp(
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        getPages: AppPage.list,
        initialBinding: AppBindings(),
        initialRoute: AppRoute.splash,
        //home: QuestionnairePage(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: (context, child) {
          return EasyLoading.init()(context, FlutterSmartDialog.init()(context, child));
        },
      ),
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..progressColor = AppTheme.lightPrimaryColor
    ..backgroundColor = Colors.white
    ..indicatorColor = AppTheme.lightPrimaryColor
    ..textColor = AppTheme.lightPrimaryColor
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}

Future<String> fetchColorCodeFromBackend() async {
  // Simulated backend fetching delay
  await Future.delayed(Duration(seconds: 2));
  return '04437d'; // Example color code in hexadecimal format
}

