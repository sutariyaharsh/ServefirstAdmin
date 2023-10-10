// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswersAdapter extends TypeAdapter<Answers> {
  @override
  final int typeId = 11;

  @override
  Answers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answers()
      .._questionId = fields[0] as String?
      .._questionText = fields[1] as String?
      .._questionType = fields[2] as String?
      .._queMaxScore = fields[3] as int?
      .._isNps = fields[4] as bool?
      .._ansMaxScore = fields[5] as int?
      .._is_Nps = fields[6] as bool?
      .._files = (fields[7] as List?)?.cast<String>()
      .._answer = fields[8] as dynamic
      .._comment = fields[9] as String?
      .._writeIn = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, Answers obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj._questionId)
      ..writeByte(1)
      ..write(obj._questionText)
      ..writeByte(2)
      ..write(obj._questionType)
      ..writeByte(3)
      ..write(obj._queMaxScore)
      ..writeByte(4)
      ..write(obj._isNps)
      ..writeByte(5)
      ..write(obj._ansMaxScore)
      ..writeByte(6)
      ..write(obj._is_Nps)
      ..writeByte(7)
      ..write(obj._files)
      ..writeByte(8)
      ..write(obj._answer)
      ..writeByte(9)
      ..write(obj._comment)
      ..writeByte(10)
      ..write(obj._writeIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
