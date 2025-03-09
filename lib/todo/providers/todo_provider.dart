import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/models/todo_model.dart';
import 'package:flutter_example_test/todo/storage/todo_storage.dart';

class TodosProvider with ChangeNotifier {
  List<Todo> _todos = [];
  final TodoStorage _storage = TodoStorage();

  List<Todo> get todos => _todos;

  Future<void> loadTodos() async {
    _todos = await _storage.loadTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    _todos.add(todo);
    await _storage.saveTodos(_todos);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((todo) => todo.id == id);
    await _storage.saveTodos(_todos);
    notifyListeners();
  }

  void editTodo(String id, String title) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      final updatedTodo = Todo(
        id: id,
        title: title,
        isCompleted: _todos[index].isCompleted,
      );
      _todos[index] = updatedTodo;
      notifyListeners();
    }
  }
}
