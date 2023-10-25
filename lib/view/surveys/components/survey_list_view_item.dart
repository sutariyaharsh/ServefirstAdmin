import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SurveyListViewItem extends StatelessWidget {
  const SurveyListViewItem({super.key, required this.survey});

  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppTheme.lightPrimaryColor, width: 1.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              survey.name ?? "",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16.sp),
            ),
          ),
          Image.asset(
            demoResponse,
            width: 80.w,
            height: 80.h,
          )
        ],
      ),
    );
  }
}
