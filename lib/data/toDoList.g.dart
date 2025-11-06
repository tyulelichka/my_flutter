// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toDoList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoTaskAdapter extends TypeAdapter<ToDoTask> {
  @override
  final int typeId = 1;

  @override
  ToDoTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoTask(
      nameTask: fields[0] as String,
      taskCompleted: fields[1] as bool?,
      nameCategory: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoTask obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameTask)
      ..writeByte(1)
      ..write(obj.taskCompleted)
      ..writeByte(2)
      ..write(obj.nameCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
