// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_dashboard_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveyDashboardDataAdapter extends TypeAdapter<SurveyDashboardData> {
  @override
  final int typeId = 3;

  @override
  SurveyDashboardData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveyDashboardData(
      totalSurveys: fields[0] as int?,
      totalResponses: fields[1] as int?,
      responseAverage: fields[2] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, SurveyDashboardData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalSurveys)
      ..writeByte(1)
      ..write(obj.totalResponses)
      ..writeByte(2)
      ..write(obj.responseAverage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyDashboardDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
