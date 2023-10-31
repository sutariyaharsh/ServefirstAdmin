import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class SurveyListViewItem extends StatelessWidget {
  const SurveyListViewItem({super.key, required this.survey, required this.isPortrait});

  final Survey survey;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w, vertical: isPortrait ? 10.h : 15.h),
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w, vertical: isPortrait ? 10.h : 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPortrait ? 10.r : 20.r),
        border: Border.all(color: AppTheme.lightPrimaryColor, width: isPortrait ? 1.r : 0.5.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              survey.name ?? "",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: isPortrait ? 16.sp : 10.sp),
            ),
          ),
          Image.asset(
            demoResponse,
            width: isPortrait ? 80 : 100,
            height: isPortrait ? 80 : 100,
          )
        ],
      ),
    );
  }
}
