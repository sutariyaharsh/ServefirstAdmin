// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_survey_pojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineSurveyPojoAdapter extends TypeAdapter<OfflineSurveyPojo> {
  @override
  final int typeId = 16;

  @override
  OfflineSurveyPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineSurveyPojo()
      ..userId = fields[0] as String?
      ..jsonData = (fields[1] as Map?)?.cast<String, SurveySubmitJsonData>()
      ..metaData = (fields[2] as Map?)?.cast<String, SurveySubmitMetaData>()
      ..responseData =
          (fields[3] as Map?)?.cast<String, SurveySubmitResponseData>()
      ..valueListMapFilesType = (fields[4] as Map?)?.map(
          (dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<Uint8List>()))
      ..valueListMapFilesAudition = (fields[5] as Map?)?.map(
          (dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<Uint8List>()));
  }

  @override
  void write(BinaryWriter writer, OfflineSurveyPojo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.jsonData)
      ..writeByte(2)
      ..write(obj.metaData)
      ..writeByte(3)
      ..write(obj.responseData)
      ..writeByte(4)
      ..write(obj.valueListMapFilesType)
      ..writeByte(5)
      ..write(obj.valueListMapFilesAudition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineSurveyPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
