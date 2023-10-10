// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_names.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageNamesAdapter extends TypeAdapter<ImageNames> {
  @override
  final int typeId = 15;

  @override
  ImageNames read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageNames(
      imageName: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageNames obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imageName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageNamesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
