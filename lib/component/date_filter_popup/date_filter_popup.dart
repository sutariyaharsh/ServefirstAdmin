import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/report/controller/report_controller.dart';

class DateFilterPopup extends StatefulWidget {
  final List<PopupMenuItem<int>> popupMenuItems;

  const DateFilterPopup({
    Key? key,
    required this.popupMenuItems,
  }) : super(key: key);

  @override
  _DateFilterPopupState createState() => _DateFilterPopupState();
}

class _DateFilterPopupState extends State<DateFilterPopup> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _textKey = GlobalKey();

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _togglePopupMenu() {
    if (_overlayEntry == null) {
      _showPopupMenu();
    } else {
      _hidePopupMenu();
    }
  }

  void _showPopupMenu() {
    final RenderBox? textRenderBox =
        _textKey.currentContext?.findRenderObject() as RenderBox?;
    final Offset textPosition =
        textRenderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    final Size textSize = textRenderBox?.size ?? Size.zero;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GetBuilder<ReportController>(
          builder: (controller) => Positioned(
            left: textPosition.dx,
            top: textPosition.dy + textSize.height,
            width: textSize.width,
            child: Container(
              margin: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.popupMenuItems.map((item) {
                  return GestureDetector(
                    onTap: () async {
                      _hidePopupMenu();
                      item.onTap?.call();
                      switch (item.value) {
                        case 1:
                          controller.filterTitle.value = "Today";
                          controller.filterDates.value = getTodayDaysDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 2:
                          controller.filterTitle.value = "Last 7 Days";
                          controller.filterDates.value = getLastSevenDaysDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 3:
                          controller.filterTitle.value = "Last 30 Days";
                          controller.filterDates.value = getLastThirtyDaysDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 4:
                          controller.filterTitle.value = "This Month";
                          controller.filterDates.value = getThisMonthDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 5:
                          controller.filterTitle.value = "Last Month";
                          controller.filterDates.value = getLastMonthDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 6:
                          controller.filterTitle.value = "Last 90 Days";
                          controller.filterDates.value = getLastNinetyDaysDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 7:
                          controller.filterTitle.value = "This Year";
                          controller.filterDates.value = getCurrentYearDateRange();
                          await controller.getSurveyDashboardData();
                          break;
                        case 8:
                          await controller.updateFilterData();
                          break;
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        color: Colors.transparent,
                        child: item.child,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hidePopupMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
      builder: (controller) => GestureDetector(
        onTap: _togglePopupMenu,
        child: Container(
          key: _textKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      controller.filterTitle.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.lightAccentColor,
                          fontSize: 12.sp),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  SvgIcon(
                    assetImage: icArrowDown,
                    color: AppTheme.lightAccentColor,
                    width: 6.w,
                    height: 6.h,
                  )
                ],
              ),
              SizedBox(height: 2.h),
              Obx(
                () => Text(
                  controller.filterDates.value,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightWhiteTextColor,
                      fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
