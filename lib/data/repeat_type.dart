import 'package:hive/hive.dart';

part 'repeat_type.g.dart';

@HiveType(typeId: 2)
enum RepeatType {
  @HiveField(0)
  none,

  @HiveField(1)
  daily,

  @HiveField(2)
  weekly,

  @HiveField(3)
  monthly,
}
