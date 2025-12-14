import 'package:hive/hive.dart';
part 'students_data.g.dart'; 

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  String name;

  @HiveField(1)
  int grade;

  @HiveField(2)
  int age;

  @HiveField(3)
  int id;

  Student({
    required this.name,
    required this.grade,
    required this.age,
    required this.id,
  });
}
