import 'dart:convert';

import 'package:flutter_example_test/todo/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoStorage {
  static const String _todoListKey = 'todoList';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> todoStrings =
        todos.map((todo) => json.encode(todo.toJson())).toList();
    await prefs.setStringList(_todoListKey, todoStrings);
  }

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList(_todoListKey);
    if (todoStrings == null) return [];
    return todoStrings
        .map((todoString) => Todo.fromJson(json.decode(todoString)))
        .toList();
  }
}
