import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/survey_screen.dart';
import 'package:servefirst_admin/view/surveys/components/survey_list_view_item.dart';
import 'package:servefirst_admin/view/surveys/controller/surveys_controller.dart';

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SurveysController(index));
    return GetBuilder<SurveysController>(
      builder: (controller) => Scaffold(
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
                    itemCount: controller.surveyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Get.to(() => SurveyScreen(
                                survey: controller.surveyList[index],
                                locationId: controller.locationId.value));
                            /*Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) =>
                                        SurveyScreen2(survey: surveysController
                                            .surveyList[index],
                                            locationId: surveysController
                                                .locationId.value)));*/
                            //Get.toNamed(AppRoute.survey, arguments: argumentsMap)!.then((value) {});
                          },
                          child: SurveyListViewItem(
                              survey: controller.surveyList[index]));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
