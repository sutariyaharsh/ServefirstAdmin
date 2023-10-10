import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/my_button.dart';
import 'package:servefirst_admin/component/questions_widget/emoji_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/employee_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/file_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/multi_select_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/radio_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/rating_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/sequence_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/skill_type_question.dart';
import 'package:servefirst_admin/component/questions_widget/text_type_question.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/model/local_response/save_survey_pojo.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';
import 'dart:math' as math;
import 'package:servefirst_admin/model/response/location_survey/question.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/controller/survey_controller.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen(
      {super.key,
      required this.survey,
      required this.locationId,
      this.saveSurveyPojo});

  final Survey survey;
  final String locationId;
  final SaveSurveyPojo? saveSurveyPojo;

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late SurveyController surveyController;
  final _pageController = PageController(initialPage: 0);
  int questionPerPage = 0;
  int totalPages = 0;
  List<Questions> listQuestion = [];
  Map<String, SurveySubmitJsonData> valueListMapSurveySubmit =
      <String, SurveySubmitJsonData>{};

  @override
  void initState() {
    super.initState();
    surveyController = Get.put(SurveyController(
        survey: widget.survey,
        locationId: widget.locationId,
        saveSurveyPojo: widget.saveSurveyPojo));
    listQuestion.assignAll(widget.survey.questions ?? []);
    questionPerPage = widget.survey.questionsPerPage!;
    totalPages = (listQuestion.length / widget.survey.questionsPerPage!).ceil();
    if (totalPages == 0) {
      totalPages = totalPages + 1;
    }

    surveyController.startIndex.value = 0;
    surveyController.endIndex.value = 0;
    surveyController.questionIndex.value = 0;
    if (surveyController.questionIndex.value == 0) {
      surveyController.endIndex.value =
          math.min(listQuestion.length, widget.survey.questionsPerPage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SurveyController>(
        builder: (controller) => Scaffold(
              extendBody: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  widget.survey.name ?? "",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.lightGrayTextColor),
                ),
                elevation: 0,
                centerTitle: false,
                titleSpacing: -15,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppTheme.lightGrayTextColor,
                  ),
                  onPressed: () {
                    if (controller.questionIndex.value == 0) {
                      if (controller.surveyJsonDataMap.isNotEmpty) {
                        showCustomDialog(context);
                      } else {
                        Get.back();
                      }
                    } else {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                ),
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: SliderTheme(
                        data: SliderThemeData(
                          thumbShape: SliderComponentShape.noThumb,
                          overlayShape: SliderComponentShape.noOverlay,
                          trackHeight: 8.h,
                          inactiveTrackColor: AppTheme.lightLighterGray,
                          activeTrackColor: AppTheme.lightPrimaryColor,
                        ),
                        child: Obx(
                          () => Slider(
                            value: controller.questionIndex.value + 1,
                            max: totalPages.toDouble(),
                            onChanged: (double value) {},
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Obx(
                        () => Text(
                          questionPerPage == 1
                              ? "Question ${controller.startIndex.value + 1} / ${listQuestion.length}"
                              : "Questions ${controller.startIndex.value + 1}-${controller.endIndex.value} / ${listQuestion.length}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemCount: totalPages,
                          onPageChanged: (page) {
                            controller.questionIndex.value = page;
                            controller.startIndex.value = 0;
                            controller.endIndex.value = 0;
                            if (page == 0) {
                              controller.endIndex.value = math.min(
                                  listQuestion.length, questionPerPage);
                            } else {
                              controller.startIndex.value =
                                  page * questionPerPage;
                              if (questionPerPage == 1) {
                                controller.endIndex.value =
                                    page * questionPerPage + 1;
                              } else {
                                controller.endIndex.value = math.min(
                                  listQuestion.length,
                                  (page * questionPerPage) + questionPerPage,
                                );
                              }
                            }
                            print(
                                "Current page ${controller.questionIndex.value} ** $page");
                          },
                          itemBuilder: (context, index) {
                            return Obx(
                              () => SingleChildScrollView(
                                physics: const ClampingScrollPhysics(),
                                child: Column(
                                  children: questionsList(
                                      controller.startIndex.value,
                                      controller.endIndex.value,
                                      widget.survey.surveyType ?? '',
                                      controller),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Obx(
                        () => MyButton(
                            onTap: () async {
                              if (controller.questionIndex.value ==
                                  (totalPages - 1)) {
                                print("Submit ");
                                await controller.saveDataAndCallApi();
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            buttonText: controller.questionIndex.value ==
                                    (totalPages - 1)
                                ? "Submit"
                                : "Next"),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  List<Widget> questionsList(int startIndex, int endIndex, String surveyType,
      SurveyController surveyController) {
    List<Widget> questionsList = [];
    for (int i = startIndex; i < endIndex; i++) {
      getLog("questionsList -- ${listQuestion[i].questionType}");
      switch (listQuestion[i].questionType) {
        case 'rating':
          questionsList.add(
            RatingTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onRatingItemSelected: (val) {
                getLog("onRatingItemSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentRating : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              onWriteInTextEntered: (val) {
                getLog("onWriteInRating : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, writeIn: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'multiselect':
          questionsList.add(
            MultiSelectTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onMultiSelectItemsSelected: (val) {
                getLog("onMultiSelectItemsSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
              onCommentTextEntered: (val) {
                getLog("onCommentMultiSelect : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              onWriteInTextEntered: (val) {
                getLog("onWriteInMultiSelect : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, writeIn: val);
              },
            ),
          );
          break;
        case 'skills':
          questionsList.add(
            SkillTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onSkillItemsSelected: (val) {
                getLog("onSkillItemsSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentSkill : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              onWriteInTextEntered: (val) {
                getLog("onWriteInSkill : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, writeIn: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'text':
          questionsList.add(
            TextTypeQuestion(
              surveyController: surveyController,
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onTextEntered: (val) {
                getLog("onTextEntered : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "text",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentText : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'employees':
          questionsList.add(
            EmployeeTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onEmployeeItemSelected: (val) {
                getLog("onEmployeeItemSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentEmployee : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'radio':
          questionsList.add(
            RadioTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onRadioItemSelected: (val) {
                getLog("onRadioItemSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentRadio : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              onWriteInTextEntered: (val) {
                getLog("onWriteInRadio : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, writeIn: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'sequence':
          questionsList.add(
            SequenceTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onSequenceItemsSelected: (val) {
                getLog("onSequenceItemsSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentRating : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              onWriteInTextEntered: (val) {
                getLog("onWriteInRating : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, writeIn: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'emoji':
          questionsList.add(
            EmojiTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onEmojiItemSelected: (val) {
                getLog("onEmojiItemSelected : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!,
                    type: "id",
                    questionType: listQuestion[i].questionType!,
                    value: val);
              },
              onCommentTextEntered: (val) {
                getLog("onCommentEmoji : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              onWriteInTextEntered: (val) {
                getLog("onWriteInEmoji : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, writeIn: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
        case 'file':
          questionsList.add(
            FileTypeQuestion(
              question: listQuestion[i],
              index: i,
              surveyType: surveyType,
              onCommentTextEntered: (val) {
                getLog("onCommentFile : $val");
                surveyController.addSurveyJsonData(
                    key: listQuestion[i].sId!, note: val);
              },
              isMultiSelectRequired: (val) {
                getLog("isMultiSelectRequired : $val");
              },
            ),
          );
          break;
      }
    }
    return questionsList;
  }
}

void showCustomDialog(BuildContext context) {
  SmartDialog.show(
      clickMaskDismiss: false,
      backDismiss: false,
      onDismiss: () {
        getLog("Dialog...Dismissed");
      },
      builder: (context) {
        return GetBuilder<SurveyController>(
          builder: (controller) => Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Save your progress and finish later? Click 'Save & Exit' to continue later, 'Exit Without Saving' to discard progress, or 'Cancel' to resume the survey now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.lightTextBlackColor,
                        fontSize: 14.sp)),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () async {
                    await controller.saveSurvey();
                    SmartDialog.dismiss();
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: AppTheme.lightPrimaryColor),
                    child: Text("Save & Exit",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightWhiteTextColor,
                            fontSize: 12.sp)),
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    SmartDialog.dismiss();
                    Get.back();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: AppTheme.lightPrimaryColor),
                    child: Text("Leave Without Saving",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightWhiteTextColor,
                            fontSize: 12.sp)),
                  ),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    SmartDialog.dismiss();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: AppTheme.lightPrimaryColor),
                    child: Text("Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightWhiteTextColor,
                            fontSize: 12.sp)),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
