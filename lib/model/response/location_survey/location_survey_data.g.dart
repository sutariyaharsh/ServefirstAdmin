// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_survey_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationSurveyDataAdapter extends TypeAdapter<LocationSurveyData> {
  @override
  final int typeId = 4;

  @override
  LocationSurveyData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationSurveyData()
      .._location = (fields[0] as List?)?.cast<Location>()
      .._global = (fields[1] as List?)?.cast<Survey>();
  }

  @override
  void write(BinaryWriter writer, LocationSurveyData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._location)
      ..writeByte(1)
      ..write(obj._global);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationSurveyDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
