import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servefirst_admin/controller/controllers.dart';
import 'package:servefirst_admin/theme/app_theme.dart';

//Shared Preferences Keys
class PrefKeys {
  static const String USER_TYPE = "USER_TYPE";
  static const String IS_EMAIL_VERIFIED = "IS_EMAIL_VERIFIED";
  static const String IS_GIG_CREATED = "IS_GIG_CREATED";
  static const String START_DATE_FILTER = "START_DATE_FILTER";
  static const String END_DATE_FILTER = "END_DATE_FILTER";
  static const String SELECTED_DATE_FILTER = "SELECTED_DATE_FILTER";
  static const String FILTER_DATES = "SELECTED_DATES";
}

void getLog(String message) {
  Get.log(isError: true, "** $message");
}

String getTodayDaysDateRange() {
  final today = DateTime.now();
  final startDate = today;
  final endDate = today;

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedStartDate = formatter.format(startDate);
  final formattedEndDate = formatter.format(endDate);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(startDate);
  final apiEndDate = formatterApi.format(endDate);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "Today");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedStartDate to $formattedEndDate");

  return '$formattedStartDate to $formattedEndDate';
}

String getLastSevenDaysDateRange() {
  final today = DateTime.now();
  final startDate = today.subtract(Duration(days: 7));
  final endDate = today;

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedStartDate = formatter.format(startDate);
  final formattedEndDate = formatter.format(endDate);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(startDate);
  final apiEndDate = formatterApi.format(endDate);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "Last 7 Days");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedStartDate to $formattedEndDate");

  return '$formattedStartDate to $formattedEndDate';
}

String getLastThirtyDaysDateRange() {
  final today = DateTime.now();
  final startDate = today.subtract(Duration(days: 20));
  final endDate = today;

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedStartDate = formatter.format(startDate);
  final formattedEndDate = formatter.format(endDate);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(startDate);
  final apiEndDate = formatterApi.format(endDate);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "Last 30 Days");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedStartDate to $formattedEndDate");

  return '$formattedStartDate to $formattedEndDate';
}

String getThisMonthDateRange() {
  final today = DateTime.now();
  final firstDayOfMonth = DateTime(today.year, today.month, 1);
  final lastDayOfMonth = DateTime(today.year, today.month + 1, 0);

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedFirstDay = formatter.format(firstDayOfMonth);
  final formattedLastDay = formatter.format(lastDayOfMonth);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(firstDayOfMonth);
  final apiEndDate = formatterApi.format(lastDayOfMonth);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "This Month");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedFirstDay to $formattedLastDay");

  return '$formattedFirstDay to $formattedLastDay';
}

String getLastMonthDateRange() {
  final today = DateTime.now();
  final firstDayOfCurrentMonth = DateTime(today.year, today.month, 1);
  final firstDayOfLastMonth = DateTime(
      firstDayOfCurrentMonth.year, firstDayOfCurrentMonth.month - 1, 1);
  final lastDayOfLastMonth = firstDayOfCurrentMonth.subtract(Duration(days: 1));

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedFirstDay = formatter.format(firstDayOfLastMonth);
  final formattedLastDay = formatter.format(lastDayOfLastMonth);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(firstDayOfLastMonth);
  final apiEndDate = formatterApi.format(lastDayOfLastMonth);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "Last Month");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedFirstDay to $formattedLastDay");

  return '$formattedFirstDay to $formattedLastDay';
}

String getLastNinetyDaysDateRange() {
  final today = DateTime.now();
  final startDate = today.subtract(Duration(days: 90));
  final endDate = today;

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedStartDate = formatter.format(startDate);
  final formattedEndDate = formatter.format(endDate);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(startDate);
  final apiEndDate = formatterApi.format(endDate);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "Last 90 Days");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedStartDate to $formattedEndDate");

  return '$formattedStartDate to $formattedEndDate';
}

String getCurrentYearDateRange() {
  final today = DateTime.now();
  final firstDayOfYear = DateTime(today.year, 1, 1);
  final lastDayOfYear = DateTime(today.year, 12, 31);

  final formatter = DateFormat('dd-MM-yyyy');

  final formattedFirstDay = formatter.format(firstDayOfYear);
  final formattedLastDay = formatter.format(lastDayOfYear);

  final formatterApi = DateFormat('yyyy-MM-dd');
  final apiStartDate = formatterApi.format(firstDayOfYear);
  final apiEndDate = formatterApi.format(lastDayOfYear);

  sharedPreferencesController.saveString(
      PrefKeys.START_DATE_FILTER, apiStartDate);
  sharedPreferencesController.saveString(PrefKeys.END_DATE_FILTER, apiEndDate);
  sharedPreferencesController.saveString(
      PrefKeys.SELECTED_DATE_FILTER, "This Year");
  sharedPreferencesController.saveString(
      PrefKeys.FILTER_DATES, "$formattedFirstDay to $formattedLastDay");

  return '$formattedFirstDay to $formattedLastDay';
}

Future<String> selectCustomDateRange(BuildContext context) async {
  DateTimeRange? selectedRange;
  final ThemeData theme = Theme.of(context);

  selectedRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    initialDateRange: DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 7)),
      end: DateTime.now(),
    ),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: AppTheme
                .lightPrimaryColor, // Customize the selection color here
          ),
          buttonTheme: theme.buttonTheme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary:
                  AppTheme.lightPrimaryColor, // Customize the button color here
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (selectedRange != null) {
    // Process the selected date range
    DateTime startDate = selectedRange.start;
    DateTime endDate = selectedRange.end;

    // Do something with the selected date range
    final formatter = DateFormat('dd-MM-yyyy');
    String formattedStartDate = formatter.format(startDate);
    String formattedEndDate = formatter.format(endDate);
    print('Selected date range: $formattedStartDate to $formattedEndDate');

    final formatterApi = DateFormat('yyyy-MM-dd');
    final apiStartDate = formatterApi.format(startDate);
    final apiEndDate = formatterApi.format(endDate);

    sharedPreferencesController.saveString(
        PrefKeys.START_DATE_FILTER, apiStartDate);
    sharedPreferencesController.saveString(
        PrefKeys.END_DATE_FILTER, apiEndDate);
    sharedPreferencesController.saveString(
        PrefKeys.SELECTED_DATE_FILTER, "Custom Range");
    sharedPreferencesController.saveString(
        PrefKeys.FILTER_DATES, "$formattedStartDate to $formattedEndDate");

    return '$formattedStartDate to $formattedEndDate';
  }

  return '';
}

String formatDateString(String inputDate) {
  // Parse the input date string using DateFormat from intl package
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateTime date;
  try {
    date = inputFormat.parse(inputDate);
  } catch (e) {
    print(e);
    return ''; // Return null or any default value if parsing fails
  }

  // Format the date to your desired output format
  DateFormat outputFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
  String formatted = outputFormat.format(date);

  // Return the formatted date
  return formatted;
}

showSnackBar({required String message}) {
  Get.snackbar(
    "",
    titleText: SizedBox.shrink(),
    message,
    backgroundColor: AppTheme.lightPrimaryColor.withOpacity(0.6),
    messageText: Text(
      message,
      style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500), // Change the text color of the message.
    ),
  );
}
