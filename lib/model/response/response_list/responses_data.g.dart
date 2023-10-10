// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponsesDataAdapter extends TypeAdapter<ResponsesData> {
  @override
  final int typeId = 10;

  @override
  ResponsesData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponsesData()
      .._createdAt = fields[0] as String?
      .._sId = fields[1] as String?
      .._survey = fields[2] as String?
      .._surveyId = fields[3] as String?
      .._surveyDescription = fields[4] as String?
      .._surveyType = fields[5] as String?
      .._surveyCreatedAt = fields[6] as String?
      .._surveyMaxScore = fields[7] as int?
      .._answers = (fields[8] as List?)?.cast<Answers>()
      .._surveyCategories = (fields[9] as List?)?.cast<SurveyCategories>()
      .._npsScore = fields[10] as int?
      .._questionScore = fields[11] as int?
      .._answerScore = fields[12] as int?
      .._resultPercent = fields[13] as num?;
  }

  @override
  void write(BinaryWriter writer, ResponsesData obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj._createdAt)
      ..writeByte(1)
      ..write(obj._sId)
      ..writeByte(2)
      ..write(obj._survey)
      ..writeByte(3)
      ..write(obj._surveyId)
      ..writeByte(4)
      ..write(obj._surveyDescription)
      ..writeByte(5)
      ..write(obj._surveyType)
      ..writeByte(6)
      ..write(obj._surveyCreatedAt)
      ..writeByte(7)
      ..write(obj._surveyMaxScore)
      ..writeByte(8)
      ..write(obj._answers)
      ..writeByte(9)
      ..write(obj._surveyCategories)
      ..writeByte(10)
      ..write(obj._npsScore)
      ..writeByte(11)
      ..write(obj._questionScore)
      ..writeByte(12)
      ..write(obj._answerScore)
      ..writeByte(13)
      ..write(obj._resultPercent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponsesDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
