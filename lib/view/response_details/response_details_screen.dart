import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/response_details/component/circular_progress_response.dart';
import 'package:servefirst_admin/view/response_details/component/response_detail_list_view_item.dart';
import 'package:servefirst_admin/view/response_details/controller/response_details_controller.dart';

class ResponseDetailsScreen extends StatelessWidget {
  const ResponseDetailsScreen({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final controller = Get.put(ResponseDetailsController(index));
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<ResponseDetailsController>(
        builder: (controller) => Scaffold(
          extendBody: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: isPortrait ? statusBarHeight : 30.h, left: 20.w, right: 20.w, bottom: isPortrait ? 20.h : 20.h),
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
                      SizedBox(width: isPortrait ? 10.w : 5.w),
                      Obx(
                        () => Text(
                          controller.responseData.value!.survey!,
                          style: TextStyle(fontSize: isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: isPortrait ? 20.w : 10.w,
                            right: isPortrait ? 20.w : 10.w,
                            bottom: isPortrait ? 20.h : 20.h,
                            top: isPortrait ? 5.h : 10.h),
                        decoration: BoxDecoration(
                            color: AppTheme.lightPrimaryColor,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r), bottomLeft: Radius.circular(25.r))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Survey type",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: isPortrait ? 13.sp : 9.sp, color: AppTheme.lightGrayColor),
                            ),
                            SizedBox(height: isPortrait ? 10.h : 20.h),
                            Obx(
                              () => Text(
                                controller.responseData.value!.surveyType!,
                                style:
                                    TextStyle(fontWeight: FontWeight.w600, fontSize: isPortrait ? 20.sp : 15.sp, color: AppTheme.lightWhiteTextColor),
                              ),
                            ),
                            SizedBox(height: isPortrait ? 5.h : 10.h),
                            Obx(
                              () => Text(
                                controller.responseData.value!.surveyDescription!,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: isPortrait ? 12.sp : 8.sp,
                                    height: 1.4,
                                    color: AppTheme.lightWhiteTextColor),
                              ),
                            ),
                            SizedBox(height: isPortrait ? 15.h : 30.h),
                            Text(
                              "Categories",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: isPortrait ? 13.sp : 9.sp, color: AppTheme.lightGrayColor),
                            ),
                            SizedBox(height: isPortrait ? 5.h : 10.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => Wrap(
                                      children: controller.categoriesList.map((item) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: isPortrait ? 5.w : 2.w, vertical: isPortrait ? 5.h : 10.h),
                                          padding: EdgeInsets.symmetric(horizontal: isPortrait ? 10.w : 5.w, vertical: isPortrait ? 3.h : 6.h),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(isPortrait ? 15.r : 30.r),
                                              border: Border.all(width: 1.w, color: Colors.white)),
                                          child: Text(
                                            item.name!,
                                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 12.sp : 8.sp, color: Colors.white),
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
                                      style:
                                          TextStyle(color: AppTheme.lightGrayColor, fontSize: isPortrait ? 12.sp : 8.sp, fontWeight: FontWeight.w500),
                                    ),
                                    Obx(
                                      () => Text(
                                        formatDateString(controller.responseData.value!.createdAt!),
                                        style: TextStyle(
                                            color: AppTheme.lightWhiteTextColor, fontSize: isPortrait ? 12.sp : 8.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isPortrait ? 10.h : 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w),
                        child: Text(
                          "Summary",
                          style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.lightGrayTextColor, fontSize: isPortrait ? 14.sp : 10.sp),
                        ),
                      ),
                      SizedBox(height: isPortrait ? 15.h : 30.h),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularProgressResponse(
                                valueText: '${controller.responseData.value!.npsScore ?? 0}',
                                value: (controller.responseData.value!.npsScore ?? 0) / 100,
                                subtitle: "Promotor",
                                trackColor: AppTheme.lightGreen,
                                title: "NPS",
                                isPortrait: isPortrait),
                            CircularProgressResponse(
                                valueText: "${controller.responseData.value!.answerScore!}/${controller.responseData.value!.questionScore!}",
                                value: controller.responseData.value!.answerScore! / controller.responseData.value!.questionScore!,
                                subtitle: "Score",
                                trackColor: AppTheme.lightRed,
                                title: "Total Score",
                                isPortrait: isPortrait),
                            CircularProgressResponse(
                                valueText: '${controller.responseData.value!.resultPercent!}',
                                value: controller.responseData.value!.resultPercent! / 100,
                                subtitle: "Promotor",
                                trackColor: AppTheme.lightRed,
                                title: "Result",
                                isPortrait: isPortrait),
                          ],
                        ),
                      ),
                      SizedBox(height: isPortrait ? 10.h : 20.h),
                      Obx(
                        () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.answersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ResponseDetailsListViewItem(answers: controller.answersList[index], index: index, isPortrait: isPortrait);
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
    });
  }
}
