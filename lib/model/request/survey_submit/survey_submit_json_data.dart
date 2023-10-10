import 'package:hive/hive.dart';
import 'package:servefirst_admin/model/request/survey_submit/image_names.dart';
part 'survey_submit_json_data.g.dart';
@HiveType(typeId: 14)
class SurveySubmitJsonData {
  @HiveField(0)
  String? note;
  @HiveField(1)
  String? type;
  @HiveField(2)
  List<ImageNames>? imageNamesList = [];
  @HiveField(3)
  bool? isFile;
  @HiveField(4)
  Object? value;
  @HiveField(5)
  String? writeInValue;
  @HiveField(6)
  String? questionType;

  SurveySubmitJsonData({
    this.note,
    this.type,
    this.imageNamesList,
    this.isFile,
    this.value,
    this.writeInValue,
    this.questionType,
  });

  factory SurveySubmitJsonData.fromJson(Map<String, dynamic> json) {
    return SurveySubmitJsonData(
      note: json['note'],
      type: json['type'],
      imageNamesList: json['image'] != null
          ? List<ImageNames>.from(
          json['image'].map((x) => ImageNames.fromJson(x)))
          : null,
      isFile: json['isFile'],
      value: json['value'],
      writeInValue: json['write_in_value'],
      questionType: json['questionType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note': note,
      'type': type,
      'image': imageNamesList?.map((x) => x.toJson()).toList(),
      'isFile': isFile,
      'value': value,
      'write_in_value': writeInValue,
      'questionType': questionType,
    };
  }
}
