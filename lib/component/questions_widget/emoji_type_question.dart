import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servefirst_admin/component/my_text_field.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/constnts/image_strings.dart';
import 'package:servefirst_admin/model/response/location_survey/question.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/controller/survey_controller.dart';

class EmojiTypeQuestion extends StatefulWidget {
  const EmojiTypeQuestion(
      {Key? key,
      required this.onEmojiItemSelected,
      required this.question,
      required this.index,
      required this.surveyType,
      required this.onCommentTextEntered,
      required this.isPortrait,
      required this.onWriteInTextEntered})
      : super(key: key);
  final Function(String, bool, int) onEmojiItemSelected;
  final Function(String) onCommentTextEntered;
  final Function(String) onWriteInTextEntered;
  final Questions question;
  final int index;
  final String surveyType;
  final bool isPortrait;

  @override
  State<EmojiTypeQuestion> createState() => _EmojiTypeQuestionState();
}

class _EmojiTypeQuestionState extends State<EmojiTypeQuestion> {
  int _selectedIndex = -1;
  bool _isShowWriteIn = false;
  bool _isShowCommentText = false;
  bool _isShowCommentInput = false;
  final _commentController = TextEditingController();

  List<String> emojiList = [
    emojiHate,
    emojiDisappointed,
    emojiNeutral,
    emojiLike,
    emojiLove,
  ];

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

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _isShowWriteIn = widget.question.options![index].writeIn!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurveyController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.isPortrait ? 15.w : 7.5.w, vertical: widget.isPortrait ? 10.h : 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.index + 1}.",
                  style: TextStyle(fontSize: widget.isPortrait ? 16.sp : 10.sp, color: AppTheme.lightPrimaryColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 5.h),
                Expanded(
                  child: Text(
                    "${widget.question.text}",
                    style: TextStyle(
                        height: 1.3, fontSize: widget.isPortrait ? 14.sp : 9.sp, color: AppTheme.lightPrimaryColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            if ((widget.question.qImages ?? []).isNotEmpty)
              Wrap(
                spacing: widget.isPortrait ? 10.w : 5.w,
                runSpacing: widget.isPortrait ? 12.h : 14.h,
                children: List.generate(
                  widget.question.qImages!.length,
                      (index) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: MemoryImage(widget.question.qImages![index]), fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.isPortrait ? 5.r : 10.r),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: widget.isPortrait ? 5.h : 10.h),
            if (widget.question.required ?? false)
              Obx(
                () => controller.surveyJsonDataMap[widget.question.sId!]?.value == null
                    ? Text("* Please select any option",
                        style: TextStyle(
                          fontSize: widget.isPortrait ? 10.sp : 6.sp,
                          color: AppTheme.lightRed,
                          fontWeight: FontWeight.w600,
                        ))
                    : Container(),
              ),
            SizedBox(height: widget.isPortrait ? 10.h : 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.isPortrait ? 10.w : 5.w),
              child: Obx(
                () => Wrap(
                  spacing: widget.isPortrait ? 12.w : 6.w,
                  runSpacing: widget.isPortrait ? 12.h : 14.h,
                  children: List.generate(
                    emojiList.length,
                    (index) => GestureDetector(
                      onTap: () {
                        _selectItem(index);
                        widget.onEmojiItemSelected('${widget.question.options![index].sId}', widget.question.options![index].finishSurvey ?? false,
                            widget.question.options![index].routeToIndex ?? 0);
                      },
                      child: Container(
                        height: widget.isPortrait ? 55 : 75,
                        width: widget.isPortrait ? 55 : 75,
                        padding: EdgeInsets.symmetric(horizontal: widget.isPortrait ? 2.w : 1.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: widget.isPortrait ? 1.w : 0.5.w,
                              color: controller.surveyJsonDataMap[widget.question.sId!]?.value != null
                                  ? findIndexById(controller.surveyJsonDataMap[widget.question.sId!]?.value as String) == index
                                      ? AppTheme.lightPrimaryColor
                                      : Colors.transparent
                                  : Colors.transparent),
                        ),
                        child: Image.asset(emojiList[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: widget.isPortrait ? 15.h : 20.h),
            if (_isShowWriteIn)
              MyTextField(
                isPortrait: widget.isPortrait,
                hint: "Add Comments",
                onChange: (val) {
                  widget.onWriteInTextEntered(val);
                },
                validation: (String? value) {
                  if (_isShowWriteIn && (value == null || value.isEmpty)) {
                    return "This field can't be empty";
                  }
                  return null;
                },
              ),
            if (widget.surveyType == "audition")
              Column(
                children: [
                  SizedBox(height: widget.isPortrait ? 15.h : 20.h),
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
                                color: AppTheme.lightPrimaryColor, fontSize: widget.isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.add,
                            size: widget.isPortrait ? 20.sp : 15.sp,
                            color: AppTheme.lightPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: widget.isPortrait ? 10.h : 15.h),
                  if (_isShowCommentInput)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: widget.isPortrait ? 10.w : 5.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.isPortrait ? 6.r : 12.r),
                          ),
                          border: Border.all(width: widget.isPortrait ? 1.w : 0.5.w, color: AppTheme.lightGray)),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: widget.isPortrait ? 80.h : 100.h,
                                child: TextFormField(
                                  controller: _commentController,
                                  textDirection: TextDirection.ltr,
                                  cursorColor: AppTheme.lightPrimaryColor,
                                  style: TextStyle(color: Colors.black, fontSize: widget.isPortrait ? 13.sp : 10.sp, fontWeight: FontWeight.w500),
                                  minLines: 1,
                                  // Set this to control the minimum number of lines to display
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      hintText: "Enter Comment",
                                      hintStyle: TextStyle(
                                          color: AppTheme.lightDarkGray, fontSize: widget.isPortrait ? 13.sp : 10.sp, fontWeight: FontWeight.w500),
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
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  if (_isShowCommentText)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: widget.isPortrait ? 10.h : 15.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(widget.isPortrait ? 6.r : 12.r),
                          ),
                          border: Border.all(width: widget.isPortrait ? 1.w : 0.5.w, color: AppTheme.lightGray)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: widget.isPortrait ? 10.w : 5.w),
                              child: Text(
                                _commentController.text,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: widget.isPortrait ? 12.sp : 8.sp, color: Colors.black),
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
                  SizedBox(height: widget.isPortrait ? 10.h : 15.h),
                  GestureDetector(
                    onTap: () {
                      _showOptionsDialog(context, controller);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Image",
                          style:
                          TextStyle(color: AppTheme.lightPrimaryColor, fontSize: widget.isPortrait ? 14.sp : 10.sp, fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.add,
                          size: widget.isPortrait ? 20.sp : 15.sp,
                          color: AppTheme.lightPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: widget.isPortrait ? 10.h : 15.h),
                  Obx(
                    () => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.imageFileAuditionListMap[widget.question.sId]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final pickedImage = /*File(*/
                            controller.imageFileAuditionListMap[widget.question.sId]![index] /*)*/;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(widget.isPortrait ? 5.r : 10.r),
                              ),
                              border: Border.all(width: 1.w, color: AppTheme.lightGray)),
                          child: ListTile(
                            leading: Container(
                              width: widget.isPortrait ? 55 : 85,
                              height: widget.isPortrait ? 55 : 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(widget.isPortrait ? 5.r : 10.r),
                                ),
                                image: DecorationImage(
                                  image: MemoryImage(pickedImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              /*pickedImage.path
                                  .split(Platform.pathSeparator)
                                  .last*/
                              "Image Name",
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: widget.isPortrait ? 12.sp : 8.sp, color: AppTheme.lightGrayTextColor),
                            ),
                            // Replace with the actual image name
                            trailing: GestureDetector(
                              onTap: () => controller.removeImageToAuditionMap(widget.question.sId!, index),
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
          title: const Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildOptionButton('Camera', () {
                Navigator.of(context).pop();
                controller.pickImage(ImageSource.camera, widget.question.questionType!, widget.question.sId!);
              }),
              _buildOptionButton('Gallery', () {
                controller.pickImage(ImageSource.gallery, widget.question.questionType!, widget.question.sId!);
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
