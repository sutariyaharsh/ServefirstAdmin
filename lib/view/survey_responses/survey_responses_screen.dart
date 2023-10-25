import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/response_details/response_details_screen.dart';
import 'package:servefirst_admin/view/survey/survey_screen.dart';
import 'package:servefirst_admin/view/survey_responses/component/survey_response_list_view_item.dart';
import 'package:servefirst_admin/view/survey_responses/controller/survey_responses_controller.dart';

class SurveyResponsesScreen extends StatelessWidget {
  const SurveyResponsesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SurveyResponsesController());
    return GetBuilder<SurveyResponsesController>(
      builder: (controller) => Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.lightGrayTextColor,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              "This Month",
                              style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.lightGrayTextColor, fontSize: 12.sp),
                            ),
                            SizedBox(width: 5.w),
                            SvgIcon(
                              assetImage: icArrowDown,
                              color: AppTheme.lightGrayTextColor,
                              width: 6.w,
                              height: 6.h,
                            )
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          "01-07-2023 to 31-01-2023",
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Obx(
                        () => controller.savedResponsesList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Text(
                                      "Saved Responses",
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppTheme.lightGrayTextColor),
                                    ),
                                  ),
                                  ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.savedResponsesList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () async {
                                            Survey? survey = await controller.getSurveyFromSurveyId(
                                                controller.savedResponsesList[index].surveyId!, controller.savedResponsesList[index].locationId!);
                                            if (survey != null) {
                                              Get.to(() => SurveyScreen(
                                                  survey: survey,
                                                  locationId: controller.savedResponsesList[index].locationId!,
                                                  saveSurveyPojo: controller.savedResponsesList[index],
                                                  savedSurveyIndex: index));
                                            }
                                          },
                                          child: SurveyResponseListViewItem(
                                              surveyName: controller.savedResponsesList[index].surveyName!,
                                              surveyCreatedAt: controller.savedResponsesList[index].createdAt!,
                                              onDeleteClick: () {},
                                              index: index));
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              "Completed Responses",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppTheme.lightGrayTextColor),
                            ),
                          ),
                          Obx(
                            () => controller.responsesDataList.isNotEmpty
                                ? ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.responsesDataList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Get.to(() => ResponseDetailsScreen(index: index));
                                          },
                                          child: SurveyResponseListViewItem(
                                              surveyName: controller.responsesDataList[index].survey!,
                                              surveyCreatedAt: controller.responsesDataList[index].createdAt!,
                                              index: index));
                                    },
                                  )
                                : Container(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
