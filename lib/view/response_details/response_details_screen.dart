import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/response_details/component/circular_progress_response.dart';
import 'package:servefirst_admin/view/response_details/component/response_detail_list_view_item.dart';
import 'package:servefirst_admin/view/response_details/controller/response_details_controller.dart';

class ResponseDetailsScreen extends StatelessWidget {
  const ResponseDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: statusBarHeight, left: 20.w, right: 20.w, bottom: 20.h),
              color: AppTheme.lightPrimaryColor,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.lightWhiteTextColor,
                    ),
                    SizedBox(width: 10.w),
                    Obx(
                      () => Text(
                        responseDetailsController.responseData.value!.survey!,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightWhiteTextColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 20.h, top: 5.h),
                      decoration: BoxDecoration(
                          color: AppTheme.lightPrimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25.r),
                              bottomLeft: Radius.circular(25.r))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Survey type",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: AppTheme.lightGrayColor),
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => Text(
                              responseDetailsController
                                  .responseData.value!.surveyType!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: AppTheme.lightWhiteTextColor),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Obx(
                            () => Text(
                              responseDetailsController
                                  .responseData.value!.surveyDescription!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  height: 1.4,
                                  color: AppTheme.lightWhiteTextColor),
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: AppTheme.lightGrayColor),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => Wrap(
                                    children: responseDetailsController
                                        .categoriesList
                                        .map((item) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 5.h),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 3.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r),
                                            border: Border.all(
                                                width: 1.w,
                                                color: Colors.white)),
                                        child: Text(
                                          item.name!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                              color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Created at",
                                    style: TextStyle(
                                        color: AppTheme.lightGrayColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Obx(
                                    () => Text(
                                      formatDateString(responseDetailsController
                                          .responseData.value!.createdAt!),
                                      style: TextStyle(
                                          color: AppTheme.lightWhiteTextColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.lightGrayTextColor,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularProgressResponse(
                              valueText:
                                  '${responseDetailsController.responseData.value!.npsScore!}',
                              value: responseDetailsController
                                      .responseData.value!.npsScore! /
                                  100,
                              subtitle: "Promotor",
                              trackColor: AppTheme.lightGreen,
                              title: "NPS"),
                          CircularProgressResponse(
                              valueText:
                                  "${responseDetailsController.responseData.value!.answerScore!}/${responseDetailsController.responseData.value!.questionScore!}",
                              value: responseDetailsController
                                      .responseData.value!.answerScore! /
                                  responseDetailsController
                                      .responseData.value!.questionScore!,
                              subtitle: "Score",
                              trackColor: AppTheme.lightRed,
                              title: "Total Score"),
                          CircularProgressResponse(
                              valueText:
                                  '${responseDetailsController.responseData.value!.resultPercent!}',
                              value: responseDetailsController
                                      .responseData.value!.resultPercent! /
                                  100,
                              subtitle: "Promotor",
                              trackColor: AppTheme.lightRed,
                              title: "Result"),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: responseDetailsController.answersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ResponseDetailsListViewItem(
                              answers:
                                  responseDetailsController.answersList[index],
                              index: index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
