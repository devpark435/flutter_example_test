import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/providers/todo_provider.dart';
import 'package:flutter_example_test/todo/todo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: const TodoApp(),
    ),
  );
}
