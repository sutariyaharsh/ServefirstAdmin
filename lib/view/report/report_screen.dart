import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/date_filter_popup/date_filter_popup.dart';
import 'package:servefirst_admin/component/date_filter_popup/popup_menu_item.dart';
import 'package:servefirst_admin/constnts/text_strings.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/route/app_route.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/report/compoenent/report_button.dart';
import 'package:servefirst_admin/view/report/compoenent/sync_button.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Container(
                      color: AppTheme.lightPrimaryColor,
                    ),
                    Container(
                      color: AppTheme.lightWhite50,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: AppTheme.lightBackgroundColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: statusBarHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      sWelcome,
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: AppTheme.lightWhiteTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SyncButton(onTap: () {
                      reportController.getLocationSurveysData();
                    }),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  sHowAreYouExperience,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.lightWhiteTextColor,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 2.h),
                Text(
                  sPerformSurveyNow,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.lightWhiteTextColor,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppTheme.lightPrimaryColor,
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 25.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sSurveys,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.lightWhiteTextColor,
                                          fontSize: 18.sp),
                                    ),
                                    const DateFilterPopup(
                                      popupMenuItems: [
                                        PopupMenuItem<int>(
                                          value: 1,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "Today"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 2,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "Last 7 Days"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 3,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "Last 30 Days"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 4,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "This Month"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 5,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "Last Month"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 6,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "Last 90 Days"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 7,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "This Year"),
                                        ),
                                        PopupMenuItem<int>(
                                          value: 8,
                                          child: FilterPopupMenuItem(
                                              filterTitle: "Custom Range"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Obx(
                                            () => CircularProgressBar(
                                              progress: reportController
                                                      .responseAverage.value! /
                                                  100,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            "Ave. Response",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.lightWhite50,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppTheme
                                                          .lightBackgroundColor),
                                                  child: Obx(
                                                    () => Text(
                                                      "${reportController.totalSurveys.value}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppTheme
                                                              .lightPrimaryColor,
                                                          fontSize: 12.sp),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  "Surveys",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppTheme
                                                          .lightWhiteTextColor,
                                                      fontSize: 12.sp),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppTheme
                                                          .lightBackgroundColor),
                                                  child: Obx(
                                                    () => Text(
                                                      "${reportController.totalResponse.value}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppTheme
                                                              .lightPrimaryColor,
                                                          fontSize: 12.sp),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Text(
                                                  "Responses",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppTheme
                                                          .lightWhiteTextColor,
                                                      fontSize: 12.sp),
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
                            decoration: BoxDecoration(
                                color: AppTheme.lightWhite50,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ReportButton(
                                    title: sPerformSurvey,
                                    onTap: () {
                                      if(reportController.locationList.isEmpty){
                                        print('Here..survet');
                                        Get.toNamed(AppRoute.surveys, arguments: 0)!
                                            .then((value) {});
                                      }else {
                                        print('Here..Location');
                                        Get.toNamed(AppRoute.location)!
                                            .then((value) {});
                                      }

                                    }),
                                SizedBox(height: 18.h),
                                ReportButton(
                                    title: sViewResponses,
                                    onTap: () {
                                      Get.toNamed(AppRoute.survey_responses)!
                                          .then((value) {});
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircularProgressBar extends StatelessWidget {
  final double progress;

  const CircularProgressBar({super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80.w,
          height: 80.h,
          child: CircularProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.lightWhite50,
            valueColor:
                AlwaysStoppedAnimation<Color>(AppTheme.lightBackgroundColor),
            strokeWidth: 4.5.w,
          ),
        ),
        Text(
          '${(progress * 100).toInt()}%',
          style:
              TextStyle(fontSize: 20.sp, color: AppTheme.lightWhiteTextColor),
        ),
      ],
    );
  }
}
