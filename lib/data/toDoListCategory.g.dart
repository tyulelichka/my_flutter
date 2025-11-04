// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toDoListCategory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoListCategoryAdapter extends TypeAdapter<ToDoListCategory> {
  @override
  final int typeId = 0;

  @override
  ToDoListCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoListCategory(
      nameCategory: fields[0] as String,
      index: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoListCategory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameCategory)
      ..writeByte(1)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoListCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
