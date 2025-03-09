import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  }) : id = const Uuid().v4();
}
