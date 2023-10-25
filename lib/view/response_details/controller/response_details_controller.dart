import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servefirst_admin/model/response/response_list/answers.dart';
import 'package:servefirst_admin/model/response/response_list/responses_data.dart';
import 'package:servefirst_admin/model/response/response_list/survey_categories.dart';
import 'package:servefirst_admin/service/local_service/local_get_response_list_service.dart';

class ResponseDetailsController extends GetxController {
  static ResponseDetailsController instance = Get.find();
  final int index;
  Rxn<ResponsesData> responseData = Rxn<ResponsesData>();
  RxList<Answers> answersList = List<Answers>.empty(growable: true).obs;
  RxList<SurveyCategories> categoriesList = List<SurveyCategories>.empty(growable: true).obs;

  ResponseDetailsController(this.index);

  final LocalGetResponseListService _localGetResponseListService = LocalGetResponseListService();

  @override
  void onInit() async {
    await _localGetResponseListService.init();
    await getResponseDetail();
    super.onInit();
  }

  Future<void> getResponseDetail() async {
    try {
      EasyLoading.show(
        dismissOnTap: false,
      );
      responseData.value = _localGetResponseListService.getResponseData()?[index];
      answersList.assignAll(responseData.value!.answers!);
      categoriesList.assignAll(responseData.value!.surveyCategories!);
      EasyLoading.dismiss();
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
