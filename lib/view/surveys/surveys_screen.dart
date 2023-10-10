import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/survey_screen.dart';
import 'package:servefirst_admin/view/surveys/components/survey_list_view_item.dart';

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: AppTheme.lightGrayTextColor),
                    Text(
                      "Dashboard",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: AppTheme.lightGrayTextColor),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: surveysController.surveyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => SurveyScreen(
                              survey: surveysController.surveyList[index],
                              locationId: surveysController.locationId.value));
                          /*Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) =>
                                      SurveyScreen2(survey: surveysController
                                          .surveyList[index],
                                          locationId: surveysController
                                              .locationId.value)));*/
                          //Get.toNamed(AppRoute.survey, arguments: argumentsMap)!.then((value) {});
                        },
                        child: SurveyListViewItem(
                            survey: surveysController.surveyList[index]));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
