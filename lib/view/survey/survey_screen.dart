import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/component/my_button.dart';
import 'package:servefirst_admin/component/my_text_field.dart';
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
import 'package:servefirst_admin/extention/string_extention.dart';
import 'package:servefirst_admin/model/local_response/save_survey_pojo.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';
import 'package:servefirst_admin/model/response/location_survey/question.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/theme/app_theme.dart';
import 'package:servefirst_admin/view/survey/controller/survey_controller.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key, required this.survey, required this.locationId, this.saveSurveyPojo, this.savedSurveyIndex});

  final Survey survey;
  final String locationId;
  final SaveSurveyPojo? saveSurveyPojo;
  final int? savedSurveyIndex;

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late SurveyController surveyController;
  final _pageController = PageController(initialPage: 0);
  int questionPerPage = 0;
  int totalPages = 0;
  List<Questions> listQuestion = [];
  RxMap<String, bool> widgetDisabledRouting = <String, bool>{}.obs;
  Map<String, SurveySubmitJsonData> valueListMapSurveySubmit = <String, SurveySubmitJsonData>{};
  final _formKey = GlobalKey<FormState>();
  Timer? idealTimer;
  bool userInteracted = false;

  @override
  void initState() {
    super.initState();
    surveyController = Get.put(SurveyController(
        survey: widget.survey, locationId: widget.locationId, saveSurveyPojo: widget.saveSurveyPojo, savedSurveyIndex: widget.savedSurveyIndex));
    listQuestion.assignAll(widget.survey.questions ?? []);
    questionPerPage = widget.survey.questionsPerPage!;
    totalPages = (listQuestion.length / widget.survey.questionsPerPage!).ceil();
    if (totalPages == 0) {
      totalPages = totalPages + 1;
    }
    if (surveyController.isHelpDesk.value) {
      totalPages = totalPages + 1;
    }

    surveyController.startIndex.value = 0;
    surveyController.endIndex.value = 0;
    surveyController.questionIndex.value = 0;
    if (surveyController.questionIndex.value == 0) {
      surveyController.endIndex.value = math.min(listQuestion.length, widget.survey.questionsPerPage!);
    }
    for (int i = 0; i < listQuestion.length; i++) {
      widgetDisabledRouting[listQuestion[i].sId!] = false;
    }
    startIdealTimer();
  }

  @override
  void dispose() {
    super.dispose();
    if (idealTimer != null && idealTimer!.isActive) {
      idealTimer!.cancel();
      log("Ideal Timer disposed..!", name: "resetIdealTimer");
    }
  }

  // Start the ideal timer.
  void startIdealTimer() {
    log("Ideal Timer started...!", name: "startIdealTimer");
    idealTimer = Timer(const Duration(seconds: 60), () async {
      log("Ideal Timer done...!", name: "startIdealTimer");
      await surveyController.saveDataAndCallApi();
    });
  }

  // Reset the ideal timer when there is user interaction.
  void resetIdealTimer() {
    if (idealTimer != null && idealTimer!.isActive) {
      idealTimer!.cancel();
      log("Ideal Timer reset...!", name: "resetIdealTimer");
      startIdealTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isPortrait = constraints.maxWidth < 768;
      return GetBuilder<SurveyController>(
          builder: (controller) => WillPopScope(
                onWillPop: () async {
                  if (controller.questionIndex.value == 0) {
                    if (controller.surveyJsonDataMap.isNotEmpty) {
                      showCustomDialog(context, isPortrait);
                    } else {
                      Get.back();
                    }
                  } else {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                  return false;
                },
                child: Listener(
                  onPointerDown: (_) {
                    userInteracted = true;
                    resetIdealTimer();
                  },
                  child: Scaffold(
                    extendBody: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Text(
                        widget.survey.name ?? "",
                        style: TextStyle(fontSize: isPortrait ? 16.sp : 10.sp, fontWeight: FontWeight.w400, color: AppTheme.lightGrayTextColor),
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
                              showCustomDialog(context, isPortrait);
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isPortrait ? 10.h : 20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w),
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
                            SizedBox(height: isPortrait ? 15.h : 30.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w),
                              child: Obx(
                                () => Text(
                                  questionPerPage == 1
                                      ? "Question ${controller.startIndex.value + 1} / ${listQuestion.length}"
                                      : "Questions ${controller.startIndex.value + 1}-${controller.endIndex.value} / ${listQuestion.length}",
                                  style: TextStyle(
                                    fontSize: isPortrait ? 16.sp : 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: isPortrait ? 10.h : 15.h),
                            Expanded(
                              child: PageView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _pageController,
                                  itemCount: totalPages,
                                  onPageChanged: (page) {
                                    controller.questionIndex.value = page;
                                    controller.startIndex.value = 0;
                                    controller.endIndex.value = 0;
                                    if (controller.isHelpDesk.value) {
                                      if (page != 0) {
                                        if ((page - 1) == 0) {
                                          controller.endIndex.value = math.min(listQuestion.length, questionPerPage);
                                        } else {
                                          controller.startIndex.value = (page - 1) * questionPerPage;
                                          if (questionPerPage == 1) {
                                            controller.endIndex.value = (page - 1) * questionPerPage + 1;
                                          } else {
                                            controller.endIndex.value = math.min(
                                              listQuestion.length,
                                              ((page - 1) * questionPerPage) + questionPerPage,
                                            );
                                          }
                                        }
                                      }
                                    } else {
                                      if (page == 0) {
                                        controller.endIndex.value = math.min(listQuestion.length, questionPerPage);
                                      } else {
                                        controller.startIndex.value = page * questionPerPage;
                                        if (questionPerPage == 1) {
                                          controller.endIndex.value = page * questionPerPage + 1;
                                        } else {
                                          controller.endIndex.value = math.min(
                                            listQuestion.length,
                                            (page * questionPerPage) + questionPerPage,
                                          );
                                        }
                                      }
                                    }
                                    log("${controller.questionIndex.value} & $page", name: "Current page");
                                  },
                                  itemBuilder: (context, index) {
                                    return Obx(
                                      () => SingleChildScrollView(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        child: controller.isHelpDesk.value
                                            ? (index == 0)
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 12.w : 6.w),
                                                        child: Text("Can we get in touch with you about your experience today ?",
                                                            style: TextStyle(
                                                                fontSize: isPortrait ? 14.sp : 10.sp,
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w500)),
                                                      ),
                                                      SizedBox(height: isPortrait ? 15.h : 20.h),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 12.w : 6.w),
                                                        child: Text(
                                                            "Leave an email or phone number if you want us to get in touch; otherwise, just leave it blank.",
                                                            style: TextStyle(
                                                                fontSize: isPortrait ? 14.sp : 8.sp,
                                                                color: AppTheme.lightDarkGray,
                                                                fontWeight: FontWeight.w500)),
                                                      ),
                                                      SizedBox(height: isPortrait ? 25.h : 35.h),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 12.w : 6.w),
                                                        child: MyTextField(
                                                          textEditingController: controller.helpDeskNameController,
                                                          hint: "Name",
                                                          isPortrait: isPortrait,
                                                          onChange: (val) {
                                                            controller.helpDeskName.value = val;
                                                          },
                                                          textInputType: TextInputType.name,
                                                          validation: (String? value) {
                                                            /*if (value == null || value.isEmpty) {
                                                            return "This field can't be empty";
                                                          }*/
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(height: isPortrait ? 15.h : 20.h),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 12.w : 6.w),
                                                        child: MyTextField(
                                                          textEditingController: controller.helpDeskEmailController,
                                                          hint: "Email",
                                                          isPortrait: isPortrait,
                                                          onChange: (val) {
                                                            controller.helpDeskEmail.value = val;
                                                          },
                                                          textInputType: TextInputType.emailAddress,
                                                          validation: (String? value) {
                                                            if (value == null || value.isEmpty) {
                                                              return null;
                                                            } else if (!value.isValidEmail) {
                                                              return "Please enter valid email";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(height: isPortrait ? 15.h : 20.h),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: isPortrait ? 12.w : 6.w),
                                                        child: MyTextField(
                                                          textEditingController: controller.helpDeskPhoneController,
                                                          hint: "Phone Number",
                                                          isPortrait: isPortrait,
                                                          onChange: (val) {
                                                            controller.helpDeskPhone.value = val;
                                                          },
                                                          textInputType: TextInputType.phone,
                                                          validation: (String? value) {
                                                            if (value == null || value.isEmpty) {
                                                              return null;
                                                            } else if (!value.isValidPhone) {
                                                              return "Please enter valid phone number";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: questionsList(controller.startIndex.value, controller.endIndex.value,
                                                        widget.survey.surveyType ?? '', controller, isPortrait),
                                                  )
                                            : Column(
                                                children: questionsList(controller.startIndex.value, controller.endIndex.value,
                                                    widget.survey.surveyType ?? '', controller, isPortrait),
                                              ),
                                      ),
                                    );
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: isPortrait ? 20.w : 10.w, vertical: isPortrait ? 10.h : 20.h),
                              child: Obx(
                                () => MyButton(
                                    isPortrait: isPortrait,
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (controller.questionIndex.value == (totalPages - 1)) {
                                          /** Data submit **/
                                          if (controller.requiredList.isNotEmpty) {
                                            showSnackBar(message: "Please fill required questions");
                                            log("requiredList : ${jsonEncode(controller.requiredList)}", name: "MyButton");
                                            return;
                                          }
                                          await controller.saveDataAndCallApi();
                                        } else {
                                          _pageController.nextPage(
                                            duration: const Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        }
                                      }
                                    },
                                    buttonText: controller.questionIndex.value == (totalPages - 1) ? "Submit" : "Next"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
    });
  }

  void scrollToWidget(int index, List<GlobalKey<State>> widgetKeys) {
    if (index < widgetKeys.length) {
      final RenderBox renderBox = widgetKeys[index].currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      Scrollable.ensureVisible(
        widgetKeys[index].currentContext!,
        alignment: 0.0,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  List<Widget> questionsList(int startIndex, int endIndex, String surveyType, SurveyController surveyController, bool isPortrait) {
    List<GlobalKey<State>> widgetKeys = List.generate(listQuestion.length, (index) => GlobalKey());
    List<Widget> questionsList = [];
    for (int i = startIndex; i < endIndex; i++) {
      log("${listQuestion[i].questionType}", name: "questionsList");
      switch (listQuestion[i].questionType) {
        // region # Case Rating...!
        case 'rating':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: RatingTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onRatingItemSelected: (val, isFinishSurvey, routeToIndex) async {
                    log("itemsSelected : $val", name: "RatingTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                      surveyController.requiredList.remove(listQuestion[i].sId!);
                      log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "RatingTypeQuestion");
                    }
                    if (!isFinishSurvey) {
                      if (routeToIndex != 0) {
                        int routeQuestionPage = ((widget.survey.questionsPerPage! + routeToIndex) / widget.survey.questionsPerPage!).floor() - 1;
                        log("RouteIndexPage : $routeToIndex & $routeQuestionPage & ${_pageController.page!.round()}", name: "RatingTypeQuestion");
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = (k < routeToIndex);
                        }
                        log("questionsDisabled : ${jsonEncode(widgetDisabledRouting)}", name: "RatingTypeQuestion");
                        if (routeQuestionPage > (_pageController.page!.round())) {
                          _pageController.animateToPage(routeQuestionPage, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        }
                        scrollToWidget(routeToIndex, widgetKeys);
                      } else {
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = false;
                        }
                        if (widget.survey.questionsPerPage! > 1) {
                          scrollToWidget((i + 1), widgetKeys);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      }
                    } else {}
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "RatingTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                  onWriteInTextEntered: (val) async {
                    log("onWriteIn : $val", name: "RatingTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, writeIn: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Multiselect...!
        case 'multiselect':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: MultiSelectTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onMultiSelectItemsSelected: (val) async {
                    log("itemsSelected : $val", name: "MultiSelectTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (val.isNotEmpty) {
                      if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                        surveyController.requiredList.remove(listQuestion[i].sId!);
                        log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "MultiSelectTypeQuestion");
                      }
                    } else {
                      if (surveyController.surveyJsonDataMap.containsKey(listQuestion[i].sId!)) {
                        surveyController.surveyJsonDataMap.remove(listQuestion[i].sId!);
                      }
                      if (listQuestion[i].required ?? false) {
                        surveyController.requiredList.add(listQuestion[i].sId!);
                      }
                    }
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "MultiSelectTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                  onWriteInTextEntered: (val) async {
                    log("onWriteIn : $val", name: "MultiSelectTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, writeIn: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Skill...!
        case 'skills':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: SkillTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onSkillItemsSelected: (val) async {
                    log("itemsSelected : $val", name: "SkillTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (val.isNotEmpty) {
                      if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                        surveyController.requiredList.remove(listQuestion[i].sId!);
                        log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "SkillTypeQuestion");
                      }
                    } else {
                      if (surveyController.surveyJsonDataMap.containsKey(listQuestion[i].sId!)) {
                        surveyController.surveyJsonDataMap.remove(listQuestion[i].sId!);
                      }
                      if (listQuestion[i].required ?? false) {
                        surveyController.requiredList.add(listQuestion[i].sId!);
                      }
                    }
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "SkillTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                  onWriteInTextEntered: (val) async {
                    log("onWriteIn : $val", name: "SkillTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, writeIn: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Text...!
        case 'text':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: TextTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  surveyController: surveyController,
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onTextEntered: (val) async {
                    log("onTextEntered : $val", name: "TextTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "text", questionType: listQuestion[i].questionType!, value: val);
                    if (val.isNotEmpty) {
                      if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                        surveyController.requiredList.remove(listQuestion[i].sId!);
                        log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "TextTypeQuestion");
                      }
                    } else {
                      if (surveyController.surveyJsonDataMap.containsKey(listQuestion[i].sId!)) {
                        surveyController.surveyJsonDataMap.remove(listQuestion[i].sId!);
                      }
                      if (listQuestion[i].required ?? false) {
                        surveyController.requiredList.add(listQuestion[i].sId!);
                      }
                    }
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "TextTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Employee...!
        case 'employees':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: EmployeeTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onEmployeeItemSelected: (val, isFinishSurvey, routeToIndex) async {
                    log("itemsSelected : $val", name: "EmployeeTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                      surveyController.requiredList.remove(listQuestion[i].sId!);
                      log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "EmployeeTypeQuestion");
                    }
                    if (!isFinishSurvey) {
                      if (routeToIndex != 0) {
                        int routeQuestionPage = ((widget.survey.questionsPerPage! + routeToIndex) / widget.survey.questionsPerPage!).floor() - 1;
                        log("RouteIndexPage : $routeToIndex & $routeQuestionPage & ${_pageController.page!.round()}", name: "EmployeeTypeQuestion");
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = (k < routeToIndex);
                        }
                        log("questionsDisabled : ${jsonEncode(widgetDisabledRouting)}", name: "EmployeeTypeQuestion");
                        if (routeQuestionPage > (_pageController.page!.round())) {
                          _pageController.animateToPage(routeQuestionPage, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        }
                      } else {
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = false;
                        }
                        if (widget.survey.questionsPerPage! > 1) {
                          scrollToWidget((i + 1), widgetKeys);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      }
                    } else {}
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "EmployeeTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Radio...!
        case 'radio':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: RadioTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onRadioItemSelected: (val, isFinishSurvey, routeToIndex) async {
                    log("itemsSelected : $val", name: "RadioTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                      surveyController.requiredList.remove(listQuestion[i].sId!);
                      log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "RadioTypeQuestion");
                    }
                    if (!isFinishSurvey) {
                      if (routeToIndex != 0) {
                        int routeQuestionPage = ((widget.survey.questionsPerPage! + routeToIndex) / widget.survey.questionsPerPage!).floor() - 1;
                        log("RouteIndexPage : $routeToIndex & $routeQuestionPage & ${_pageController.page!.round()}", name: "RadioTypeQuestion");
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = (k < routeToIndex);
                        }
                        log("questionsDisabled : ${jsonEncode(widgetDisabledRouting)}", name: "RadioTypeQuestion");
                        if (routeQuestionPage > (_pageController.page!.round())) {
                          _pageController.animateToPage(routeQuestionPage, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        }
                      } else {
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = false;
                        }
                        if (widget.survey.questionsPerPage! > 1) {
                          scrollToWidget((i + 1), widgetKeys);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      }
                    } else {}
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "RadioTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                  onWriteInTextEntered: (val) async {
                    log("onWriteIn : $val", name: "RadioTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, writeIn: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Sequence...!
        case 'sequence':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: SequenceTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onSequenceItemsSelected: (val) async {
                    log("itemsSelected : $val", name: "SequenceTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (val.isNotEmpty) {
                      if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                        surveyController.requiredList.remove(listQuestion[i].sId!);
                        log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "SequenceTypeQuestion");
                      }
                    } else {
                      if (surveyController.surveyJsonDataMap.containsKey(listQuestion[i].sId!)) {
                        surveyController.surveyJsonDataMap.remove(listQuestion[i].sId!);
                      }
                      if (listQuestion[i].required ?? false) {
                        surveyController.requiredList.add(listQuestion[i].sId!);
                      }
                    }
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "SequenceTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                  onWriteInTextEntered: (val) async {
                    log("onWriteIn : $val", name: "SequenceTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, writeIn: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case Emoji...!
        case 'emoji':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: EmojiTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onEmojiItemSelected: (val, isFinishSurvey, routeToIndex) async {
                    log("itemsSelected : $val", name: "EmojiTypeQuestion");
                    await surveyController.addSurveyJsonData(
                        key: listQuestion[i].sId!, type: "id", questionType: listQuestion[i].questionType!, value: val);
                    if (surveyController.requiredList.contains(listQuestion[i].sId!)) {
                      surveyController.requiredList.remove(listQuestion[i].sId!);
                      log("onRemove : ${jsonEncode(surveyController.requiredList)}", name: "EmojiTypeQuestion");
                    }
                    if (!isFinishSurvey) {
                      if (routeToIndex != 0) {
                        int routeQuestionPage = ((widget.survey.questionsPerPage! + routeToIndex) / widget.survey.questionsPerPage!).floor() - 1;
                        log("RouteIndexPage : $routeToIndex & $routeQuestionPage & ${_pageController.page!.round()}", name: "EmojiTypeQuestion");
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = (k < routeToIndex);
                        }
                        log("questionsDisabled : ${jsonEncode(widgetDisabledRouting)}", name: "EmojiTypeQuestion");
                        if (routeQuestionPage > (_pageController.page!.round())) {
                          _pageController.animateToPage(routeQuestionPage, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                        }
                      } else {
                        for (int k = (i + 1); k < listQuestion.length; k++) {
                          widgetDisabledRouting[listQuestion[k].sId!] = false;
                        }
                        if (widget.survey.questionsPerPage! > 1) {
                          scrollToWidget((i + 1), widgetKeys);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      }
                    } else {}
                  },
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "EmojiTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                  onWriteInTextEntered: (val) async {
                    log("onWriteIn : $val", name: "EmojiTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, writeIn: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
        // region # Case File...!
        case 'file':
          questionsList.add(
            IgnorePointer(
              ignoring: widgetDisabledRouting[listQuestion[i].sId!]!,
              child: Opacity(
                opacity: widgetDisabledRouting[listQuestion[i].sId]! ? 0.5 : 1.0,
                child: FileTypeQuestion(
                  isPortrait: isPortrait,
                  key: widgetKeys[i],
                  question: listQuestion[i],
                  index: i,
                  surveyType: surveyType,
                  onCommentTextEntered: (val) async {
                    log("onComment : $val", name: "FileTypeQuestion");
                    await surveyController.addSurveyJsonData(key: listQuestion[i].sId!, note: val);
                  },
                ),
              ),
            ),
          );
          break;
        // endregion
      }
    }
    return questionsList;
  }
}

void showCustomDialog(BuildContext context, bool isPortrait) {
  SmartDialog.show(
      clickMaskDismiss: false,
      backDismiss: false,
      onDismiss: () {
        log("Dismissed..!", name: "Dialog");
      },
      builder: (context) {
        return GetBuilder<SurveyController>(
          builder: (controller) => Container(
            margin: EdgeInsets.symmetric(horizontal: isPortrait ? 30.w : 15.w),
            padding: EdgeInsets.symmetric(horizontal: isPortrait ? 15.w : 7.5.w, vertical: 20.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(isPortrait ? 12.r : 24.r)), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Save your progress and finish later? Click 'Save & Exit' to continue later, 'Exit Without Saving' to discard progress, or 'Cancel' to resume the survey now.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 1.5, fontWeight: FontWeight.w500, color: AppTheme.lightTextBlackColor, fontSize: isPortrait ? 14.sp : 10.sp)),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(isPortrait ? 8.r : 16.r)), color: AppTheme.lightPrimaryColor),
                    child: Text("Save & Exit",
                        style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor, fontSize: isPortrait ? 12.sp : 8.sp)),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(isPortrait ? 8.r : 16.r)), color: AppTheme.lightPrimaryColor),
                    child: Text("Leave Without Saving",
                        style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor, fontSize: isPortrait ? 12.sp : 8.sp)),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(isPortrait ? 8.r : 16.r)), color: AppTheme.lightPrimaryColor),
                    child: Text("Cancel",
                        style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.lightWhiteTextColor, fontSize: isPortrait ? 12.sp : 8.sp)),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
