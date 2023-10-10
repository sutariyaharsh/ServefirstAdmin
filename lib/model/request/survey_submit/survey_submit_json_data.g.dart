// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_submit_json_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveySubmitJsonDataAdapter extends TypeAdapter<SurveySubmitJsonData> {
  @override
  final int typeId = 14;

  @override
  SurveySubmitJsonData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveySubmitJsonData(
      note: fields[0] as String?,
      type: fields[1] as String?,
      imageNamesList: (fields[2] as List?)?.cast<ImageNames>(),
      isFile: fields[3] as bool?,
      value: fields[4] as Object?,
      writeInValue: fields[5] as String?,
      questionType: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SurveySubmitJsonData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.note)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.imageNamesList)
      ..writeByte(3)
      ..write(obj.isFile)
      ..writeByte(4)
      ..write(obj.value)
      ..writeByte(5)
      ..write(obj.writeInValue)
      ..writeByte(6)
      ..write(obj.questionType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveySubmitJsonDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
