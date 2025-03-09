import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/models/todo_model.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  // 새 할 일 추가
  void addTodo(String title) {
    if (title.trim().isNotEmpty) {
      _todos.add(Todo(title: title));
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void editTodo(String id, String title) {
    final todo = _todos.firstWhere((todo) => todo.id == id);
    todo.title = title;
    notifyListeners();
  }
}
