// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TourAdapter extends TypeAdapter<Tour> {
  @override
  final int typeId = 2;

  @override
  Tour read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tour().._status = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Tour obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TourAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
