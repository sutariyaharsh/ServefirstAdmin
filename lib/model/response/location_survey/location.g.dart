// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 5;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location()
      .._sId = fields[0] as String?
      .._companyId = fields[1] as String?
      .._name = fields[2] as String?
      .._address1 = fields[3] as String?
      .._address2 = fields[4] as String?
      .._longitude = fields[5] as double?
      .._latitude = fields[6] as double?
      .._employee = (fields[7] as List?)?.cast<Employee>()
      .._distance = fields[8] as String?
      .._surveys = (fields[9] as List?)?.cast<Survey>();
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj._sId)
      ..writeByte(1)
      ..write(obj._companyId)
      ..writeByte(2)
      ..write(obj._name)
      ..writeByte(3)
      ..write(obj._address1)
      ..writeByte(4)
      ..write(obj._address2)
      ..writeByte(5)
      ..write(obj._longitude)
      ..writeByte(6)
      ..write(obj._latitude)
      ..writeByte(7)
      ..write(obj._employee)
      ..writeByte(8)
      ..write(obj._distance)
      ..writeByte(9)
      ..write(obj._surveys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
