import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/model/response/location_survey/question.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/controller/survey_controller.dart';

class TextTypeQuestion extends StatefulWidget {
  const TextTypeQuestion(
      {Key? key,
      required this.surveyController,
      required this.question,
      required this.index,
      required this.onTextEntered,
      required this.surveyType,
      required this.onCommentTextEntered})
      : super(key: key);

  final Questions question;
  final int index;
  final Function(String) onTextEntered;
  final Function(String) onCommentTextEntered;
  final String surveyType;
  final SurveyController surveyController;

  @override
  State<TextTypeQuestion> createState() => _TextTypeQuestionState();
}

class _TextTypeQuestionState extends State<TextTypeQuestion> {
  bool _isShowCommentText = false;
  bool _isShowCommentInput = false;
  final _commentController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initialize the _textController with the initial value from myController.value
    if (widget.surveyController.surveyJsonDataMap[widget.question.sId!]?.value != null) {
      _textController.text = widget.surveyController.surveyJsonDataMap[widget.question.sId!]?.value as String;
    }

    // Observe changes in myController.value and update _textController accordingly
    ever(widget.surveyController.surveyJsonDataMap, (_) {
      final surveyData = widget.surveyController.surveyJsonDataMap[widget.question.sId!];
      if (surveyData != null) {
        if (mounted) {
          setState(() {
            _textController.text = surveyData.value.toString(); // Assuming 'value' is not an RxString
          });
        }
      }
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
                  style: TextStyle(fontSize: 16.sp, color: AppTheme.lightPrimaryColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: Text(
                    "${widget.question.text}",
                    style: TextStyle(height: 1.3, fontSize: 14.sp, color: AppTheme.lightPrimaryColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            if (widget.question.required ?? false)
              Obx(
                () => controller.surveyJsonDataMap[widget.question.sId!]?.value == null
                    ? Text("* Please Enter your thoughts",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppTheme.lightRed,
                          fontWeight: FontWeight.w600,
                        ))
                    : Container(),
              ),
            SizedBox(height: 10.h),
            Container(
              height: 80.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.r),
                  ),
                  border: Border.all(width: 1.w, color: AppTheme.lightGray)),
              child: TextFormField(
                controller: _textController,
                onChanged: (text) {
                  widget.onTextEntered(text);
                },
                textDirection: TextDirection.ltr,
                cursorColor: AppTheme.lightPrimaryColor,
                style: TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w500),
                minLines: 1,
                // Set this to control the minimum number of lines to display
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "Type here...",
                    hintStyle: TextStyle(color: AppTheme.lightDarkGray, fontSize: 13.sp, fontWeight: FontWeight.w500),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(height: 15.h),
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
                            style: TextStyle(color: AppTheme.lightPrimaryColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
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
                          border: Border.all(width: 1.w, color: AppTheme.lightGray)),
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
                                  style: TextStyle(color: Colors.black, fontSize: 13.sp, fontWeight: FontWeight.w500),
                                  minLines: 1,
                                  // Set this to control the minimum number of lines to display
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      hintText: "Enter Comment",
                                      hintStyle: TextStyle(color: AppTheme.lightDarkGray, fontSize: 13.sp, fontWeight: FontWeight.w500),
                                      border: InputBorder.none),
                                ),
                              ),
                              IconButton(
                                color: AppTheme.lightPrimaryColor,
                                onPressed: () {
                                  if (_commentController.text.trim().isEmpty) {
                                    showSnackBar(message: "Comment should not be empty!");
                                  } else {
                                    widget.onCommentTextEntered(_commentController.text);
                                    _showCommentText();
                                  }
                                },
                                icon: Icon(Icons.send),
                              ),
                            ],
                          ),
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
                          border: Border.all(width: 1.w, color: AppTheme.lightGray)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                _commentController.text,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: Colors.black),
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
                            icon: Icon(Icons.cancel, color: AppTheme.lightPrimaryColor.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () {
                      _showOptionsDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Image",
                          style: TextStyle(color: AppTheme.lightPrimaryColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
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
                      itemCount: controller.imageFileAuditionListMap[widget.question.sId]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final pickedImage = /*File(*/
                            controller.imageFileAuditionListMap[widget.question.sId]![index] /*)*/;
                        return AuditionImageListItem(
                            pickedImage: pickedImage, onDeleteClick: () => controller.removeImageToAuditionMap(widget.question.sId!, index));
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

  void _showOptionsDialog(BuildContext context) {
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
                widget.surveyController.pickImage(ImageSource.camera, widget.question.questionType!, widget.question.sId!);
              }),
              _buildOptionButton('Gallery', () {
                widget.surveyController.pickImage(ImageSource.gallery, widget.question.questionType!, widget.question.sId!);
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
}

class AuditionImageListItem extends StatelessWidget {
  const AuditionImageListItem({
    super.key,
    required this.pickedImage,
    required this.onDeleteClick,
  });

  final Uint8List pickedImage;
  final VoidCallback onDeleteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.r),
          ),
          border: Border.all(width: 1.w, color: AppTheme.lightGray)),
      child: ListTile(
        leading: Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5.r),
            ),
            image: DecorationImage(
              image: MemoryImage(pickedImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          /*pickedImage.path.split(Platform.pathSeparator)
                                  .last*/
          "Image Name",
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, color: AppTheme.lightGrayTextColor),
        ),
        // Replace with the actual image name
        trailing: GestureDetector(
          onTap: onDeleteClick,
          child: Icon(
            Icons.delete,
            color: AppTheme.lightRed,
          ),
        ),
      ),
    );
  }
}
