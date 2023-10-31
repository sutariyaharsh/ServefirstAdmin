// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionsAdapter extends TypeAdapter<Options> {
  @override
  final int typeId = 9;

  @override
  Options read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Options()
      .._text = fields[0] as String?
      .._value = fields[1] as int?
      .._iconClass = fields[2] as String?
      .._imageUrl = fields[3] as String?
      .._aImageUrl = fields[4] as Uint8List?
      .._writeIn = fields[5] as bool?
      .._finishSurvey = fields[6] as bool?
      .._routeToIndex = fields[7] as int?
      .._sId = fields[8] as String?;
  }

  @override
  void write(BinaryWriter writer, Options obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj._text)
      ..writeByte(1)
      ..write(obj._value)
      ..writeByte(2)
      ..write(obj._iconClass)
      ..writeByte(3)
      ..write(obj._imageUrl)
      ..writeByte(4)
      ..write(obj._aImageUrl)
      ..writeByte(5)
      ..write(obj._writeIn)
      ..writeByte(6)
      ..write(obj._finishSurvey)
      ..writeByte(7)
      ..write(obj._routeToIndex)
      ..writeByte(8)
      ..write(obj._sId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
