// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoCategoryAdapter extends TypeAdapter<ToDoCategory> {
  @override
  final int typeId = 0;

  @override
  ToDoCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoCategory(
      categoryId: fields[0] as String,
      name: fields[1] as String,
      iconName: fields[2] as String,
      isDefault: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoCategory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.categoryId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconName)
      ..writeByte(3)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
