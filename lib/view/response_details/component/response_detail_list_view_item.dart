import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/model/response/response_list/answers.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

class ResponseDetailsListViewItem extends StatelessWidget {
  const ResponseDetailsListViewItem({super.key, required this.answers, required this.index});

  final Answers answers;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppTheme.lightGray, width: 1.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answers.questionText!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, height: 1.4, color: AppTheme.lightGrayTextColor),
          ),
          SizedBox(height: 10.h),
          if (answers.answer != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(color: AppTheme.lightLighterGray, borderRadius: BorderRadius.circular(5.r)),
              child: answers.answer is List<String>
                  ? Text(
                      (answers.answer as List<String>).join(", "),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, height: 1.4, color: AppTheme.lightDarkGray),
                    )
                  : Text(
                      '${answers.answer}',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, height: 1.4, color: AppTheme.lightDarkGray),
                    ),
            ),
          if (answers.writeIn != null && answers.writeIn!.isNotEmpty)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(color: AppTheme.lightLighterGray, borderRadius: BorderRadius.circular(5.r)),
              child: Text(
                answers.writeIn!,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, height: 1.4, color: AppTheme.lightDarkGray),
              ),
            ),
          if (answers.comment != null && answers.comment!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  "Comment",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, color: AppTheme.lightGrayTextColor),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 5.h),
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(color: AppTheme.lightLighterGray, borderRadius: BorderRadius.circular(5.r)),
                  child: Text(
                    answers.comment!,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, height: 1.4, color: AppTheme.lightDarkGray),
                  ),
                ),
              ],
            ),
          SizedBox(height: 10.h),
          if (answers.files != null)
            Wrap(
              children: answers.files!.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppTheme.lightLighterGray,
                    borderRadius: BorderRadius.circular(5.r),
                    image: DecorationImage(
                      image: AssetImage(item),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              }).toList(),
            ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Score",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp, height: 1.4, color: AppTheme.lightGrayTextColor),
              ),
              SizedBox(width: 5.w),
              Text(
                '${answers.ansMaxScore}/${answers.queMaxScore}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, height: 1.4, color: AppTheme.lightPrimaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
