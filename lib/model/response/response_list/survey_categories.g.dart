// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_categories.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveyCategoriesAdapter extends TypeAdapter<SurveyCategories> {
  @override
  final int typeId = 12;

  @override
  SurveyCategories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveyCategories()
      .._sId = fields[0] as String?
      .._name = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, SurveyCategories obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._sId)
      ..writeByte(1)
      ..write(obj._name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveyCategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
