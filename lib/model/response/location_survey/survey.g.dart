// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveyAdapter extends TypeAdapter<Survey> {
  @override
  final int typeId = 7;

  @override
  Survey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Survey()
      .._sId = fields[0] as String?
      .._name = fields[1] as String?
      .._description = fields[2] as String?
      .._questionsPerPage = fields[3] as int?
      .._companyId = fields[4] as String?
      .._surveyType = fields[5] as String?
      .._questions = (fields[6] as List?)?.cast<Questions>()
      .._userTagId = fields[7] as String?
      .._image = fields[8] as String?
      .._maxScore = fields[9] as int?
      .._status = fields[10] as bool?
      .._isGlobal = fields[11] as bool?
      .._showIn = fields[12] as String?
      .._helpDesk = fields[13] as bool?
      .._showCategory = fields[14] as bool?
      .._updatedAt = fields[15] as String?
      .._createdAt = fields[16] as String?
      .._iV = fields[17] as int?
      .._leadershipUserId = fields[18] as String?
      .._responseNotificationMails = fields[19] as String?
      .._idealDuration = fields[20] as int?;
  }

  @override
  void write(BinaryWriter writer, Survey obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj._sId)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._description)
      ..writeByte(3)
      ..write(obj._questionsPerPage)
      ..writeByte(4)
      ..write(obj._companyId)
      ..writeByte(5)
      ..write(obj._surveyType)
      ..writeByte(6)
      ..write(obj._questions)
      ..writeByte(7)
      ..write(obj._userTagId)
      ..writeByte(8)
      ..write(obj._image)
      ..writeByte(9)
      ..write(obj._maxScore)
      ..writeByte(10)
      ..write(obj._status)
      ..writeByte(11)
      ..write(obj._isGlobal)
      ..writeByte(12)
      ..write(obj._showIn)
      ..writeByte(13)
      ..write(obj._helpDesk)
      ..writeByte(14)
      ..write(obj._showCategory)
      ..writeByte(15)
      ..write(obj._updatedAt)
      ..writeByte(16)
      ..write(obj._createdAt)
      ..writeByte(17)
      ..write(obj._iV)
      ..writeByte(18)
      ..write(obj._leadershipUserId)
      ..writeByte(19)
      ..write(obj._responseNotificationMails)
      ..writeByte(20)
      ..write(obj._idealDuration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
