import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/date_filter_popup/date_filter_popup.dart';
import 'package:servefirst_admin/component/date_filter_popup/popup_menu_item.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/location/location_screen.dart';
import 'package:servefirst_admin/view/report/compoenent/report_button.dart';
import 'package:servefirst_admin/view/report/compoenent/sync_button.dart';
import 'package:servefirst_admin/view/report/controller/report_controller.dart';
import 'package:servefirst_admin/view/survey_responses/survey_responses_screen.dart';
import 'package:servefirst_admin/view/surveys/surveys_screen.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      log("$isPortrait", name: "Device");
      return GetBuilder<ReportController>(
        builder: (controller) => Scaffold(
          extendBody: true,
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        Container(color: AppTheme.lightPrimaryColor),
                        Container(color: AppTheme.lightWhite50),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(color: AppTheme.lightBackgroundColor),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isPortrait ? statusBarHeight : 40.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                sWelcome,
                                style:
                                    TextStyle(fontSize: isPortrait ? 22.sp : 12.sp, color: AppTheme.lightWhiteTextColor, fontWeight: FontWeight.w500),
                              ),
                              SyncButton(
                                  onTap: () async {
                                    await controller.getLocationSurveys(true);
                                  },
                                  isPortrait: isPortrait),
                            ],
                          ),
                          SizedBox(height: isPortrait ? 12.h : 10.h),
                          Text(
                            sHowAreYouExperience,
                            style: TextStyle(fontSize: isPortrait ? 16.sp : 8.sp, color: AppTheme.lightWhiteTextColor, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: isPortrait ? 2.h : 4.h),
                          Text(
                            sPerformSurveyNow,
                            style: TextStyle(fontSize: isPortrait ? 16.sp : 8.sp, color: AppTheme.lightWhiteTextColor, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: isPortrait ? 30.h : 20.h),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: AppTheme.lightPrimaryColor, borderRadius: BorderRadius.circular(15.r)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: isPortrait ? 12.h : 20.h, horizontal: isPortrait ? 25.w : 12.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                sSurveys,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme.lightWhiteTextColor,
                                                    fontSize: isPortrait ? 18.sp : 10.sp),
                                              ),
                                              DateFilterPopup(
                                                titleFontSize: isPortrait ? 12.sp : 8.sp,
                                                dateFontSize: isPortrait ? 12.sp : 8.sp,
                                                popupMenuItems: [
                                                  PopupMenuItem<int>(
                                                    value: 1,
                                                    child: FilterPopupMenuItem(filterTitle: "Today", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 2,
                                                    child: FilterPopupMenuItem(filterTitle: "Last 7 Days", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 3,
                                                    child: FilterPopupMenuItem(filterTitle: "Last 30 Days", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 4,
                                                    child: FilterPopupMenuItem(filterTitle: "This Month", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 5,
                                                    child: FilterPopupMenuItem(filterTitle: "Last Month", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 6,
                                                    child: FilterPopupMenuItem(filterTitle: "Last 90 Days", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 7,
                                                    child: FilterPopupMenuItem(filterTitle: "This Year", isPortrait: isPortrait),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 8,
                                                    child: FilterPopupMenuItem(filterTitle: "Custom Range", isPortrait: isPortrait),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Obx(
                                                      () => CircularProgressBar(
                                                        progress: controller.responseAverage.value! / 100,
                                                        fontSize: isPortrait ? 20.sp : 10.sp,
                                                        width: isPortrait ? 80 : 100,
                                                        height: isPortrait ? 80 : 100,
                                                        strokeWidth: isPortrait ? 4.w : 2.w,
                                                      ),
                                                    ),
                                                    SizedBox(height: isPortrait ? 8.h : 15.h),
                                                    Text(
                                                      "Ave. Response",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          color: AppTheme.lightWhite50,
                                                          fontSize: isPortrait ? 11.sp : 6.sp),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(child: Container()),
                                                Container(
                                                  margin: EdgeInsets.only(bottom: isPortrait ? 10.h : 20.h),
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: isPortrait ? 35 : 45,
                                                            height: isPortrait ? 35 : 45,
                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.lightBackgroundColor),
                                                            child: Obx(
                                                              () => Text(
                                                                "${controller.totalSurveys.value}",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: AppTheme.lightPrimaryColor,
                                                                    fontSize: isPortrait ? 14.sp : 8.sp),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: isPortrait ? 8.w : 4.w),
                                                          Text(
                                                            "Surveys",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                color: AppTheme.lightWhiteTextColor,
                                                                fontSize: isPortrait ? 14.sp : 8.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: isPortrait ? 15.h : 25.h),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: isPortrait ? 35 : 45,
                                                            height: isPortrait ? 35 : 45,
                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.lightBackgroundColor),
                                                            child: Obx(
                                                              () => Text(
                                                                "${controller.totalResponse.value}",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    color: AppTheme.lightPrimaryColor,
                                                                    fontSize: isPortrait ? 14.sp : 8.sp),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: isPortrait ? 8.w : 4.w),
                                                          Text(
                                                            "Responses",
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.w600,
                                                                color: AppTheme.lightWhiteTextColor,
                                                                fontSize: isPortrait ? 14.sp : 8.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: AppTheme.lightWhite50, borderRadius: BorderRadius.circular(15.r)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ReportButton(
                                              verticalPadding: isPortrait ? 14.h : 28.h,
                                              title: sPerformSurvey,
                                              titleFontSize: isPortrait ? 13.sp : 8.sp,
                                              onTap: () {
                                                if (controller.locationList.isEmpty) {
                                                  Get.to(() => const SurveysScreen(index: 0));
                                                } else {
                                                  Get.to(() => const LocationScreen());
                                                }
                                              }),
                                          SizedBox(height: isPortrait ? 18.h : 30.h),
                                          ReportButton(
                                              verticalPadding: isPortrait ? 14.h : 28.h,
                                              title: sViewResponses,
                                              titleFontSize: isPortrait ? 13.sp : 8.sp,
                                              onTap: () {
                                                Get.to(() => const SurveyResponsesScreen());
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: isPortrait ? 110.h : 200.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CircularProgressBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;
  final double strokeWidth;
  final double fontSize;

  const CircularProgressBar({
    super.key,
    required this.progress,
    required this.width,
    required this.height,
    required this.strokeWidth,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.lightWhite50,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.lightBackgroundColor),
            strokeWidth: strokeWidth,
          ),
        ),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(fontSize: fontSize, color: AppTheme.lightWhiteTextColor),
        ),
      ],
    );
  }
}
