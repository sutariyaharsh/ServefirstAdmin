// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_survey_pojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveSurveyPojoAdapter extends TypeAdapter<SaveSurveyPojo> {
  @override
  final int typeId = 13;

  @override
  SaveSurveyPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveSurveyPojo()
      ..surveyId = fields[0] as String?
      ..surveyName = fields[1] as String?
      ..createdAt = fields[2] as String?
      ..locationId = fields[3] as String?
      ..userId = fields[4] as String?
      ..valueListMapSurveySubmit =
          (fields[5] as Map?)?.cast<String, SurveySubmitJsonData>()
      ..valueListMapFilesType = (fields[6] as Map?)?.map(
          (dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<String>()))
      ..valueListMapFilesAudition = (fields[7] as Map?)?.map(
          (dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<Uint8List>()));
  }

  @override
  void write(BinaryWriter writer, SaveSurveyPojo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.surveyId)
      ..writeByte(1)
      ..write(obj.surveyName)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.locationId)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.valueListMapSurveySubmit)
      ..writeByte(6)
      ..write(obj.valueListMapFilesType)
      ..writeByte(7)
      ..write(obj.valueListMapFilesAudition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveSurveyPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
