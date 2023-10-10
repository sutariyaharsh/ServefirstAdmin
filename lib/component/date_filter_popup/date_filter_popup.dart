import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

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
  late String filterTitle;
  late String filterDates;

  void _updateFilterData() async {
    String filter_title = "Custom Range";
    String filter_Dates = await selectCustomDateRange(context);
    reportController.getSurveyDashboardData();

    setState(() {
      this.filterTitle = filter_title;
      this.filterDates = filter_Dates;
      // that were retrieved asynchronously.
    });
  }

  @override
  void initState() {
    super.initState();
    if(sharedPreferencesController.getString(PrefKeys.SELECTED_DATE_FILTER).isEmpty && sharedPreferencesController.getString(PrefKeys.FILTER_DATES).isEmpty) {
      filterTitle = "This Month";
      filterDates = getThisMonthDateRange();
    }else {
      filterTitle = sharedPreferencesController.getString(PrefKeys.SELECTED_DATE_FILTER);
      filterDates = sharedPreferencesController.getString(PrefKeys.FILTER_DATES);
    }
  }

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
        return Positioned(
          left: textPosition.dx,
          top: textPosition.dy + textSize.height,
          width: textSize.width,
          child: Container(
            margin: EdgeInsets.only(top: 5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.popupMenuItems.map((item) {
                return GestureDetector(
                  onTap: () {
                    _hidePopupMenu();
                    item.onTap?.call();
                    switch(item.value){
                      case 1:
                        setState(() {
                          filterTitle = "Today";
                          filterDates = getTodayDaysDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 2:
                        setState(() {
                          filterTitle = "Last 7 Days";
                          filterDates = getLastSevenDaysDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 3:
                        setState(() {
                          filterTitle = "Last 30 Days";
                          filterDates = getLastThirtyDaysDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 4:
                        setState(() {
                          filterTitle = "This Month";
                          filterDates = getThisMonthDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 5:
                        setState(() {
                          filterTitle = "Last Month";
                          filterDates = getLastMonthDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 6:
                        setState(() {
                          filterTitle = "Last 90 Days";
                          filterDates = getLastNinetyDaysDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 7:
                        setState(() {
                          filterTitle = "This Year";
                          filterDates = getCurrentYearDateRange();
                        });
                        reportController.getSurveyDashboardData();
                        break;
                      case 8:
                        _updateFilterData();
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
    return GestureDetector(
      onTap: _togglePopupMenu,
      child: Container(
        key: _textKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  filterTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.lightAccentColor,
                      fontSize: 12.sp),
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
            Text(
              filterDates,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightWhiteTextColor,
                  fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
