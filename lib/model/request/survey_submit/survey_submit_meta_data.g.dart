// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_submit_meta_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveySubmitMetaDataAdapter extends TypeAdapter<SurveySubmitMetaData> {
  @override
  final int typeId = 17;

  @override
  SurveySubmitMetaData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveySubmitMetaData(
      surveyId: fields[0] as String?,
      locationId: fields[1] as String?,
      responseUserId: fields[2] as String?,
      tagId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SurveySubmitMetaData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.surveyId)
      ..writeByte(1)
      ..write(obj.locationId)
      ..writeByte(2)
      ..write(obj.responseUserId)
      ..writeByte(3)
      ..write(obj.tagId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveySubmitMetaDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
