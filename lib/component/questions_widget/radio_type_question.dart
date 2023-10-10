import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servefirst_admin/component/my_text_field.dart';
import 'package:servefirst_admin/component/svg_icon.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/model/response/location_survey/question.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/controller/survey_controller.dart';

class RadioTypeQuestion extends StatefulWidget {
  const RadioTypeQuestion(
      {Key? key,
      required this.onRadioItemSelected,
      required this.question,
      required this.index,
      required this.surveyType,
      required this.onCommentTextEntered,
      required this.isMultiSelectRequired,
      required this.onWriteInTextEntered})
      : super(key: key);
  final Function(String) onRadioItemSelected;
  final Function(String) onCommentTextEntered;
  final Function(String) onWriteInTextEntered;
  final Function(bool) isMultiSelectRequired;
  final Questions question;
  final int index;
  final String surveyType;

  @override
  State<RadioTypeQuestion> createState() => _RadioTypeQuestionState();
}

class _RadioTypeQuestionState extends State<RadioTypeQuestion> {
  int _selectedIndex = -1;
  bool _isShowWriteIn = false;
  bool _isShowCommentText = false;
  bool _isShowCommentInput = false;
  final _commentController = TextEditingController();

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _isShowWriteIn = widget.question.options![index].writeIn!;
    });
  }

  void _showCommentText() {
    setState(() {
      _isShowCommentInput = false;
      _isShowCommentText = !_isShowCommentText;
    });
  }

  void _showCommentInput() {
    setState(() {
      _isShowCommentInput = !_isShowCommentInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.isMultiSelectRequired(widget.question.required ?? false);
      /*if (widget.surveyController.surveyJsonDataMap[widget.question.sId!]
              ?.value !=
          null) {
        _selectedIndex = findIndexById(widget.surveyController
            .surveyJsonDataMap[widget.question.sId!]?.value as String);
      }*/
    });
    return GetBuilder<SurveyController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.index + 1}.",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.lightPrimaryColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: Text(
                    "${widget.question.text}",
                    style: TextStyle(
                        height: 1.3,
                        fontSize: 14.sp,
                        color: AppTheme.lightPrimaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Obx(
                () => Wrap(
                  spacing: 12.w,
                  runSpacing: 12.h,
                  children: List.generate(
                    widget.question.options!.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _selectItem(index);
                        widget.onRadioItemSelected(
                            '${widget.question.options![index].sId}');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                            color: controller
                                        .surveyJsonDataMap[widget.question.sId!]
                                        ?.value !=
                                    null
                                ? findIndexById(controller
                                            .surveyJsonDataMap[
                                                widget.question.sId!]
                                            ?.value as String) ==
                                        index
                                    ? AppTheme.lightPrimaryColor
                                    : Colors.transparent
                                : Colors.transparent,
                            border: Border.all(
                                width: 1.w, color: AppTheme.lightPrimaryColor)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgIcon(
                                assetImage: controller
                                            .surveyJsonDataMap[
                                                widget.question.sId!]
                                            ?.value !=
                                        null
                                    ? findIndexById(controller
                                                .surveyJsonDataMap[
                                                    widget.question.sId!]
                                                ?.value as String) ==
                                            index
                                        ? icRadioChecked
                                        : icRadioUnChecked
                                    : icRadioUnChecked,
                                width: 20.w,
                                height: 20.h,
                                color: controller
                                            .surveyJsonDataMap[
                                                widget.question.sId!]
                                            ?.value !=
                                        null
                                    ? findIndexById(controller
                                                .surveyJsonDataMap[
                                                    widget.question.sId!]
                                                ?.value as String) ==
                                            index
                                        ? Colors.white
                                        : Colors.black
                                    : Colors.black),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                '${widget.question.options![index].text}',
                                style: TextStyle(
                                    color: controller
                                                .surveyJsonDataMap[
                                                    widget.question.sId!]
                                                ?.value !=
                                            null
                                        ? findIndexById(controller
                                                    .surveyJsonDataMap[
                                                        widget.question.sId!]
                                                    ?.value as String) ==
                                                index
                                            ? Colors.white
                                            : Colors.black
                                        : Colors.black,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            if (_isShowWriteIn)
              MyTextField(
                hint: "Add Comments",
                onChange: (val) {
                  widget.onWriteInTextEntered(val);
                },
              ),
            if (widget.surveyType == "audition")
              Column(
                children: [
                  SizedBox(height: 15.h),
                  if (!_isShowCommentText && !_isShowCommentInput)
                    GestureDetector(
                      onTap: () {
                        _showCommentInput();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add Comments",
                            style: TextStyle(
                                color: AppTheme.lightPrimaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.add,
                            size: 20.sp,
                            color: AppTheme.lightPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10.h),
                  if (_isShowCommentInput)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.r),
                          ),
                          border: Border.all(
                              width: 1.w, color: AppTheme.lightGray)),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 80.h,
                                child: TextFormField(
                                  controller: _commentController,
                                  textDirection: TextDirection.ltr,
                                  cursorColor: AppTheme.lightPrimaryColor,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500),
                                  minLines: 1,
                                  // Set this to control the minimum number of lines to display
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      hintText: "Enter Comment",
                                      hintStyle: TextStyle(
                                          color: AppTheme.lightDarkGray,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                color: AppTheme.lightPrimaryColor,
                                onPressed: () {
                                  if (_commentController.text.trim().isEmpty) {
                                    showSnackBar(
                                        message:
                                            "Comment should not be empty!");
                                  } else {
                                    widget.onCommentTextEntered(
                                        _commentController.text);
                                    _showCommentText();
                                  }
                                },
                                icon: Icon(Icons.send),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  if (_isShowCommentText)
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.r),
                          ),
                          border: Border.all(
                              width: 1.w, color: AppTheme.lightGray)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                _commentController.text,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          IconButton(
                            color: AppTheme.lightPrimaryColor,
                            onPressed: () {
                              setState(() {
                                _commentController.clear();
                                widget.onCommentTextEntered('');
                                _isShowCommentText = false;
                                _isShowCommentInput = false;
                              });
                            },
                            icon: Icon(Icons.cancel,
                                color: AppTheme.lightPrimaryColor
                                    .withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      _showOptionsDialog(context, controller);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Image",
                          style: TextStyle(
                              color: AppTheme.lightPrimaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.add,
                          size: 20.sp,
                          color: AppTheme.lightPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller
                              .imageFileAuditionListMap[widget.question.sId]
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        final pickedImage = File(
                            controller.imageFileAuditionListMap[
                                widget.question.sId]![index]);
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.r),
                              ),
                              border: Border.all(
                                  width: 1.w, color: AppTheme.lightGray)),
                          child: ListTile(
                            leading: Container(
                              width: 55.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.r),
                                ),
                                image: DecorationImage(
                                  image: FileImage(pickedImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              pickedImage.path
                                  .split(Platform.pathSeparator)
                                  .last,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: AppTheme.lightGrayTextColor),
                            ),
                            // Replace with the actual image name
                            trailing: GestureDetector(
                              onTap: () => controller.removeImageToAuditionMap(
                                  widget.question.sId!, index),
                              child: Icon(
                                Icons.delete,
                                color: AppTheme.lightRed,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, SurveyController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOptionButton('Camera', () {
                Navigator.of(context).pop();
                controller.pickImage(ImageSource.camera,
                    widget.question.questionType!, widget.question.sId!);
              }),
              _buildOptionButton('Gallery', () {
                controller.pickImage(ImageSource.gallery,
                    widget.question.questionType!, widget.question.sId!);
              }),
              _buildOptionButton('Cancel', () {
                // Handle Cancel option
                Navigator.of(context).pop();
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(String text, VoidCallback onPressed) {
    return ListTile(
      title: Text(text),
      onTap: onPressed,
    );
  }

  int findIndexById(String id) {
    for (int i = 0; i < widget.question.options!.length; i++) {
      if (widget.question.options![i].sId == id) {
        return i;
      }
    }
    return -1; // Return -1 if the id was not found in the list
  }
}
