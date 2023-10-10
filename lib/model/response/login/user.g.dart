// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      .._tour = fields[0] as Tour?
      .._sId = fields[1] as String?
      .._name = fields[2] as String?
      .._email = fields[3] as String?
      .._phone = fields[4] as String?
      .._password = fields[5] as String?
      .._type = fields[6] as String?
      .._companyId = fields[7] as String?
      .._locationId = (fields[8] as List?)?.cast<String>()
      .._isActive = fields[9] as bool?
      .._allowEmail = fields[10] as bool?
      .._isShow = fields[11] as bool?
      .._allowComplainMails = fields[12] as bool?
      .._includeInRatings = fields[13] as bool?
      .._image = fields[14] as String?
      .._locationName = (fields[15] as List?)?.cast<String>()
      .._sfv1OldUserId = fields[16] as String?
      .._userEmailSettings = fields[17] as String?
      .._createdAt = fields[18] as String?
      .._updatedAt = fields[19] as String?
      .._iV = fields[20] as int?;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj._tour)
      ..writeByte(1)
      ..write(obj._sId)
      ..writeByte(2)
      ..write(obj._name)
      ..writeByte(3)
      ..write(obj._email)
      ..writeByte(4)
      ..write(obj._phone)
      ..writeByte(5)
      ..write(obj._password)
      ..writeByte(6)
      ..write(obj._type)
      ..writeByte(7)
      ..write(obj._companyId)
      ..writeByte(8)
      ..write(obj._locationId)
      ..writeByte(9)
      ..write(obj._isActive)
      ..writeByte(10)
      ..write(obj._allowEmail)
      ..writeByte(11)
      ..write(obj._isShow)
      ..writeByte(12)
      ..write(obj._allowComplainMails)
      ..writeByte(13)
      ..write(obj._includeInRatings)
      ..writeByte(14)
      ..write(obj._image)
      ..writeByte(15)
      ..write(obj._locationName)
      ..writeByte(16)
      ..write(obj._sfv1OldUserId)
      ..writeByte(17)
      ..write(obj._userEmailSettings)
      ..writeByte(18)
      ..write(obj._createdAt)
      ..writeByte(19)
      ..write(obj._updatedAt)
      ..writeByte(20)
      ..write(obj._iV);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
