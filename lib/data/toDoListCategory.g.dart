// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toDoListCategory.dart';

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
    return ToDoCategory(name: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, ToDoCategory obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
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
