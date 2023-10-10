// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionsAdapter extends TypeAdapter<Questions> {
  @override
  final int typeId = 8;

  @override
  Questions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Questions()
      .._text = fields[0] as String?
      .._subText = fields[1] as String?
      .._questionType = fields[2] as String?
      .._categoryId = fields[3] as String?
      .._journeyType = fields[4] as String?
      .._maxScore = fields[5] as int?
      .._required = fields[6] as bool?
      .._minOptions = fields[7] as int?
      .._maxOptions = fields[8] as int?
      .._options = (fields[9] as List?)?.cast<Options>()
      .._isNps = fields[10] as bool?
      .._sId = fields[11] as String?;
  }

  @override
  void write(BinaryWriter writer, Questions obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj._text)
      ..writeByte(1)
      ..write(obj._subText)
      ..writeByte(2)
      ..write(obj._questionType)
      ..writeByte(3)
      ..write(obj._categoryId)
      ..writeByte(4)
      ..write(obj._journeyType)
      ..writeByte(5)
      ..write(obj._maxScore)
      ..writeByte(6)
      ..write(obj._required)
      ..writeByte(7)
      ..write(obj._minOptions)
      ..writeByte(8)
      ..write(obj._maxOptions)
      ..writeByte(9)
      ..write(obj._options)
      ..writeByte(10)
      ..write(obj._isNps)
      ..writeByte(11)
      ..write(obj._sId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
