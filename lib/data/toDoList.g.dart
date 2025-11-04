// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toDoList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoListAdapter extends TypeAdapter<ToDoList> {
  @override
  final int typeId = 1;

  @override
  ToDoList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoList(
      nameTask: fields[0] as String,
      taskCompleted: fields[1] as bool,
      categoryNames: fields[2] as String,
      onChanged: fields[3],
    );
  }

  @override
  void write(BinaryWriter writer, ToDoList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nameTask)
      ..writeByte(1)
      ..write(obj.taskCompleted)
      ..writeByte(2)
      ..write(obj.categoryNames)
      ..writeByte(3)
      ..write(obj.onChanged);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
