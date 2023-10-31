import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/model/response/response_list/answers.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class ResponseDetailsListViewItem extends StatelessWidget {
  const ResponseDetailsListViewItem({super.key, required this.answers, required this.index, required this.isPortrait});

  final Answers answers;
  final int index;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w, vertical: isPortrait ? 10.h : 20.h),
      padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.w, vertical: isPortrait ? 12.h : 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPortrait ? 10.r : 20.r),
        border: Border.all(color: AppTheme.lightGray, width: isPortrait ? 1.w : 0.5.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answers.questionText!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightGrayTextColor),
          ),
          SizedBox(height: isPortrait ? 10.h : 20.h),
          if (answers.answer != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 10.w : 5.w, vertical: isPortrait ? 10.h : 20.h),
              decoration: BoxDecoration(color: AppTheme.lightLighterGray, borderRadius: BorderRadius.circular(isPortrait ? 5.r : 10.r)),
              child: answers.answer is List<String>
                  ? Text(
                      (answers.answer as List<String>).join(", "),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightDarkGray),
                    )
                  : Text(
                      '${answers.answer}',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightDarkGray),
                    ),
            ),
          if (answers.writeIn != null && answers.writeIn!.isNotEmpty)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: isPortrait ? 10.h : 20.h),
              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 10.w : 5.w, vertical: isPortrait ? 10.h : 20.h),
              decoration: BoxDecoration(color: AppTheme.lightLighterGray, borderRadius: BorderRadius.circular(isPortrait ? 5.r : 10.r)),
              child: Text(
                answers.writeIn!,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightDarkGray),
              ),
            ),
          if (answers.comment != null && answers.comment!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isPortrait ? 10.h : 20.h),
                Text(
                  "Comment",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: isPortrait ? 14.sp : 10.sp, color: AppTheme.lightGrayTextColor),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: isPortrait ? 5.h : 10.h),
                  padding: EdgeInsets.symmetric(horizontal: isPortrait ? 10.w : 5.w, vertical: isPortrait ? 10.h : 20.h),
                  decoration: BoxDecoration(color: AppTheme.lightLighterGray, borderRadius: BorderRadius.circular(isPortrait ? 5.r : 10.r)),
                  child: Text(
                    answers.comment!,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightDarkGray),
                  ),
                ),
              ],
            ),
          SizedBox(height: isPortrait ? 10.h : 20.h),
          if (answers.files != null)
            Wrap(
              children: answers.files!.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: isPortrait ? 5.w : 2.w),
                  width: isPortrait ? 60 : 100,
                  height: isPortrait ? 60 : 100,
                  decoration: BoxDecoration(
                    color: AppTheme.lightLighterGray,
                    borderRadius: BorderRadius.circular(isPortrait ? 5.r : 10.r),
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              }).toList(),
            ),
          SizedBox(height: isPortrait ? 10.h : 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Score",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightGrayTextColor),
              ),
              SizedBox(width: isPortrait ? 5.w : 2.w),
              Text(
                '${answers.ansMaxScore}/${answers.queMaxScore}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: isPortrait ? 14.sp : 10.sp, height: 1.4, color: AppTheme.lightPrimaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
