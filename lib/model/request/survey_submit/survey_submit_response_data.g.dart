// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_submit_response_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SurveySubmitResponseDataAdapter
    extends TypeAdapter<SurveySubmitResponseData> {
  @override
  final int typeId = 18;

  @override
  SurveySubmitResponseData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurveySubmitResponseData(
      customerName: fields[0] as String?,
      customerEmail: fields[1] as String?,
      customerPhone: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SurveySubmitResponseData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.customerName)
      ..writeByte(1)
      ..write(obj.customerEmail)
      ..writeByte(2)
      ..write(obj.customerPhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurveySubmitResponseDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
