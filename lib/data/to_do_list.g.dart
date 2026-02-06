// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_list.dart';

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
      id: fields[0] as String,
      nameTask: fields[1] as String,
      completed: fields[2] as bool,
      idCategory: fields[3] as String,
      isFavorite: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoTask obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameTask)
      ..writeByte(2)
      ..write(obj.completed)
      ..writeByte(3)
      ..write(obj.idCategory)
      ..writeByte(4)
      ..write(obj.isFavorite);
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
