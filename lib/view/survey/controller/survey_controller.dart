import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:servefirst_admin/constnts/constants.dart';
import 'package:servefirst_admin/model/local_response/save_survey_pojo.dart';
import 'package:servefirst_admin/model/request/survey_submit/image_names.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_json_data.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_meta_data.dart';
import 'package:servefirst_admin/model/request/survey_submit/survey_submit_response_data.dart';
import 'package:servefirst_admin/model/response/location_survey/employee.dart';
import 'package:servefirst_admin/model/response/location_survey/survey.dart';
import 'package:servefirst_admin/service/local_service/local_employee_service.dart';
import 'package:servefirst_admin/service/local_service/local_get_location_surveys_service.dart';
import 'package:servefirst_admin/service/local_service/local_login_service.dart';
import 'package:servefirst_admin/service/local_service/local_save_survey_service.dart';
import 'package:servefirst_admin/service/remote_service/remote_submit_survey_service.dart';

class SurveyController extends GetxController {
  static SurveyController instance = Get.find();
  final LocalGetLocationSurveysService _localGetLocationSurveysService =
      LocalGetLocationSurveysService();
  final LocalSaveSurveyService _localSaveSurveyService =
      LocalSaveSurveyService();
  final LocalLoginService _localLoginService = LocalLoginService();
  final LocalEmployeeService _localEmployeeService = LocalEmployeeService();
  Rxn<Survey> survey = Rxn<Survey>();
  Rxn<SaveSurveyPojo> saveSurveyPojo = Rxn<SaveSurveyPojo>();
  RxList<Employee> employeeList = List<Employee>.empty(growable: true).obs;
  RxString locationId = ''.obs;
  RxString helpDeskName = ''.obs;
  RxString helpDeskEmail = ''.obs;
  RxString helpDeskPhone = ''.obs;
  var questionIndex = 0.obs;
  var startIndex = 0.obs;
  var endIndex = 0.obs;

  SurveyController(
      {Survey? survey, String? locationId, SaveSurveyPojo? saveSurveyPojo}) {
    this.survey.value = survey;
    this.locationId.value = locationId!;
    this.saveSurveyPojo.value = saveSurveyPojo;
  }

  RxMap<String, SurveySubmitJsonData> surveyJsonDataMap =
      <String, SurveySubmitJsonData>{}.obs;
  RxMap<String, SurveySubmitMetaData> surveyMetaDataMap =
      <String, SurveySubmitMetaData>{}.obs;
  RxMap<String, SurveySubmitResponseData> surveyResponseDataMap =
      <String, SurveySubmitResponseData>{}.obs;
  RxMap<String, List<Uint8List>> imageFileAuditionListMap =
      <String, List<Uint8List>>{}.obs;
  RxMap<String, List<String>> imageFileListMap =
      <String, List<String>>{}.obs;

  Future<void> saveSurvey() async {
    try {
      EasyLoading.show(
        dismissOnTap: false,
      );
      SaveSurveyPojo saveSurveyPojo = SaveSurveyPojo();
      saveSurveyPojo.surveyId = survey.value?.sId;
      saveSurveyPojo.surveyName = survey.value?.name;
      saveSurveyPojo.locationId = locationId.value;
      saveSurveyPojo.createdAt = survey.value?.createdAt;
      saveSurveyPojo.userId = _localLoginService.getUser()!.sId;
      saveSurveyPojo.valueListMapSurveySubmit = surveyJsonDataMap;
      saveSurveyPojo.valueListMapFilesType = imageFileListMap;
      saveSurveyPojo.valueListMapFilesAudition = imageFileAuditionListMap;
      _localSaveSurveyService.addSurvey(saveSurveyPojo: saveSurveyPojo);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> addSurveyJsonData(
      {required String key,
      String? note,
      String? writeIn,
      String? type,
      String? questionType,
      Object? value,
      bool? isFile}) async {
    if (!surveyJsonDataMap.containsKey(key)) {
      SurveySubmitJsonData surveySubmitJsonData = SurveySubmitJsonData();
      surveySubmitJsonData.note = note ?? '';
      surveySubmitJsonData.type = type!;
      surveySubmitJsonData.isFile = isFile ?? false;
      surveySubmitJsonData.value = value!;
      surveySubmitJsonData.writeInValue = writeIn ?? '';
      surveySubmitJsonData.questionType = questionType!;
      surveySubmitJsonData.imageNamesList = [];
      surveyJsonDataMap[key] = surveySubmitJsonData;
    } else {
      if (note != null) surveyJsonDataMap[key]!.note = note;
      if (type != null) surveyJsonDataMap[key]!.type = type;
      if (questionType != null) {
        surveyJsonDataMap[key]!.questionType = questionType;
      }
      if (writeIn != null) surveyJsonDataMap[key]!.writeInValue = writeIn;
      if (value != null) surveyJsonDataMap[key]!.value = value;
      if (isFile != null) surveyJsonDataMap[key]!.isFile = isFile;
    }

    getLog(jsonEncode(surveyJsonDataMap));
  }

  Future<void> addImageToAuditionMap(
      String key, String imagePath, String qType, Uint8List imgMemoryData) async {
    if (!imageFileAuditionListMap.containsKey(key)) {
      imageFileAuditionListMap[key] = <Uint8List>[].obs;
    }
    imageFileAuditionListMap[key]!.add(imgMemoryData);
    if (surveyJsonDataMap.containsKey(key)) {
      if (surveyJsonDataMap[key]?.imageNamesList == null) {
        surveyJsonDataMap[key]?.imageNamesList = [];
      }
      surveyJsonDataMap[key]?.imageNamesList?.add(
          ImageNames(imageName: imagePath.split(Platform.pathSeparator).last));
      surveyJsonDataMap[key]?.isFile = true;
      surveyJsonDataMap[key]?.questionType = qType;
    } else {
      SurveySubmitJsonData surveySubmitJsonData = SurveySubmitJsonData();
      surveySubmitJsonData.isFile = true;
      surveySubmitJsonData.questionType = qType;
      surveySubmitJsonData.imageNamesList = [];
      surveySubmitJsonData.imageNamesList!.add(
          ImageNames(imageName: imagePath.split(Platform.pathSeparator).last));
      surveyJsonDataMap[key] = surveySubmitJsonData;
    }

    log(jsonEncode(surveyJsonDataMap), name: "surveyJsonDataMap");
  }

  Future<void> addImageToFileMap(String key, String imagePath) async {
    if (!imageFileListMap.containsKey(key)) {
      imageFileListMap[key] = <String>[].obs;
    }
    imageFileListMap[key]!.add(imagePath);
    List<ImageNames> imageNamesList = [];
    if (surveyJsonDataMap.containsKey(key)) {
      imageNamesList = (surveyJsonDataMap[key]?.value != null)
          ? surveyJsonDataMap[key]?.value as List<ImageNames>
          : [];
      imageNamesList.add(
          ImageNames(imageName: imagePath.split(Platform.pathSeparator).last));
      surveyJsonDataMap[key]?.value = imageNamesList;
      surveyJsonDataMap[key]?.isFile = true;
      surveyJsonDataMap[key]?.type = "file";
      surveyJsonDataMap[key]?.questionType = "file";
    } else {
      SurveySubmitJsonData surveySubmitJsonData = SurveySubmitJsonData();
      surveySubmitJsonData.isFile = true;
      surveySubmitJsonData.type = "file";
      surveySubmitJsonData.questionType = "file";
      imageNamesList.add(
          ImageNames(imageName: imagePath.split(Platform.pathSeparator).last));
      surveySubmitJsonData.value = imageNamesList;
      surveyJsonDataMap[key] = surveySubmitJsonData;
    }

    getLog('${jsonEncode(surveyJsonDataMap)}');
  }

  Future<void> removeImageToAuditionMap(String key, int index) async {
    imageFileAuditionListMap[key]?.removeAt(index);
    List<ImageNames> imageNamesList = [];
    if (surveyJsonDataMap.containsKey(key)) {
      imageNamesList = (surveyJsonDataMap[key]?.value != null)
          ? surveyJsonDataMap[key]?.value as List<ImageNames>
          : [];
      if (surveyJsonDataMap[key]!.imageNamesList!.isNotEmpty) {
        surveyJsonDataMap[key]!.imageNamesList!.removeAt(index);
      }
      if (surveyJsonDataMap[key]!.imageNamesList!.isEmpty) {
        if (imageNamesList.isEmpty) {
          surveyJsonDataMap[key]?.isFile = false;
        } else {
          surveyJsonDataMap[key]?.isFile = true;
        }
      }
    }
    getLog('${jsonEncode(surveyJsonDataMap)}');
  }

  Future<void> removeImageToFileMap(String key, int index) async {
    imageFileListMap[key]?.removeAt(index);
    List<ImageNames> imageNamesList = [];
    if (surveyJsonDataMap.containsKey(key)) {
      imageNamesList = (surveyJsonDataMap[key]?.value != null)
          ? surveyJsonDataMap[key]?.value as List<ImageNames>
          : [];
      if (imageNamesList.isNotEmpty) {
        imageNamesList.removeAt(index);
      }
      if (imageNamesList.isEmpty) {
        if (surveyJsonDataMap[key]!.imageNamesList!.isEmpty) {
          surveyJsonDataMap[key]?.isFile = false;
        } else {
          surveyJsonDataMap[key]?.isFile = true;
        }
      }
      surveyJsonDataMap[key]?.value = imageNamesList;
    }
    getLog('${jsonEncode(surveyJsonDataMap)}');
  }

  void addResponseData({String? name, String? email, String? phone}) {
    helpDeskName.value = name ?? helpDeskName.value;
    helpDeskEmail.value = email ?? helpDeskEmail.value;
    helpDeskPhone.value = phone ?? helpDeskPhone.value;
  }

  @override
  void onInit() async {
    await _localLoginService.init();
    await _localGetLocationSurveysService.init();
    await _localEmployeeService.init();
    await _localSaveSurveyService.init();

    if (locationId.isNotEmpty) {
      for (var employee in _localEmployeeService.getEmployees()) {
        if (employee.locationId == locationId) {
          employeeList.assignAll(_localEmployeeService.getEmployees());
        }
      }
    }

    if(saveSurveyPojo.value != null){
      getLog("surveyJsonDataMap : ${jsonEncode(saveSurveyPojo.value!.valueListMapSurveySubmit!)}");
      surveyJsonDataMap.value = saveSurveyPojo.value!.valueListMapSurveySubmit!;
      getLog("RatingTypeOnInit : ${jsonEncode(surveyJsonDataMap["643fdd3086e290d28f36cd2c"]?.value)}");

      imageFileAuditionListMap.value = saveSurveyPojo.value!.valueListMapFilesAudition!;
      imageFileListMap.value = saveSurveyPojo.value!.valueListMapFilesType!;
    }

    SurveySubmitMetaData submitMetaData = SurveySubmitMetaData();
    submitMetaData.locationId = locationId.value;
    submitMetaData.surveyId = survey.value!.sId ?? "";
    submitMetaData.responseUserId = _localLoginService.getUser()!.sId ?? "";
    surveyMetaDataMap["SurveySubmitMetaData"] = submitMetaData;

    SurveySubmitResponseData submitResponseData = SurveySubmitResponseData();
    submitResponseData.customerName = helpDeskName.value;
    submitResponseData.customerEmail = helpDeskEmail.value;
    submitResponseData.customerPhone = helpDeskPhone.value;
    surveyResponseDataMap["SurveySubmitResponseData"] = submitResponseData;

    super.onInit();
  }

  Future<void> saveDataAndCallApi() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      getLog('You\'re not connected to a network');
    } else {
      getLog('You\'re connected to a ${connectivityResult.name} network');
      try {
        EasyLoading.show(
          dismissOnTap: false,
        );
        List<http.MultipartFile> multipartFilesList = [];
        // Loop through the map and its values (lists of files)
        await Future.wait(imageFileAuditionListMap.entries.map((entry) async {
          final key = entry.key;
          final uint8List = entry.value;

          await Future.wait(uint8List.map((uint8ListImg) async {
            String? imageFilePath = await saveImageToTempDirectory(uint8ListImg);
            var imagePart =
                await http.MultipartFile.fromPath(key, imageFilePath ?? "");
            multipartFilesList.add(imagePart);
          }));
        }));

        await Future.wait(imageFileListMap.entries.map((entry) async {
          final key = entry.key;
          final fileList = entry.value;

          await Future.wait(fileList.map((imageFilePath) async {
            var imagePart =
                await http.MultipartFile.fromPath(key, imageFilePath);
            multipartFilesList.add(imagePart);
          }));
        }));

        getLog('MultiPartFileList : ${multipartFilesList.length}');
        var result = await RemoteSubmitSurveyService().submitSurvey(
            multipartFiles: multipartFilesList,
            surveySubmitJsonData: jsonEncode(surveyJsonDataMap),
            surveySubmitMetaData:
                jsonEncode(surveyMetaDataMap["SurveySubmitMetaData"]),
            surveySubmitResponseData:
                jsonEncode(surveyResponseDataMap["SurveySubmitResponseData"]),
            token: _localLoginService.getToken()!);
        if (result.statusCode == 200) {
          var responseBody = await result.stream.bytesToString();
          EasyLoading.showSuccess("Survey Submitted!");
        } else {
          getLog(jsonDecode(await result.stream.bytesToString()));
          EasyLoading.showError('Something wrong. Try again!');
        }
      } catch (e) {
        debugPrint(e.toString());
        EasyLoading.showError('Something wrong. Try again!');
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  Future<void> pickImage(ImageSource source, String qType, String qId) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      String? cropImgPath = await _cropImage(imagePath: image.path);
      Uint8List? imageMemoryData = await getImageAsUint8List(cropImgPath ?? "");
      if (qType != "FileAnswer") {
        addImageToAuditionMap(qId, cropImgPath ?? "", qType, imageMemoryData ?? Uint8List(0));
      } else {
        addImageToFileMap(qId, cropImgPath ?? "");
      }
      Get.back();
    } on PlatformException catch (e) {
      log("catch : ${e.toString()}", name: "pickImage");
      Get.back();
    }
  }

  Future<String?> _cropImage({required String imagePath}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imagePath);
    if (croppedImage == null) return null;
    log(croppedImage.path, name: "_cropImage");
    return croppedImage.path;
  }

  Future<Uint8List?> getImageAsUint8List(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      final Uint8List uint8list = await file.readAsBytes();
      return uint8list;
    }
    return null;
  }

  Future<String?> saveImageToTempDirectory(Uint8List imageBytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final filePath = '${tempDir.path}/$uniqueFileName.jpg';
      final File imageFile = File(filePath);

      await imageFile.writeAsBytes(imageBytes);
      return filePath;
    } catch (e) {
      print("Error saving image to the temporary directory: $e");
      return null;
    }
  }
}
