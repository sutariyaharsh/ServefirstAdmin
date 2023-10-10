// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeAdapter extends TypeAdapter<Employee> {
  @override
  final int typeId = 6;

  @override
  Employee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Employee()
      .._locationId = fields[0] as String?
      .._name = fields[1] as String?
      .._id = fields[2] as String?
      .._image = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, Employee obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._locationId)
      ..writeByte(1)
      ..write(obj._name)
      ..writeByte(2)
      ..write(obj._id)
      ..writeByte(3)
      ..write(obj._image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
