import 'package:flutter/material.dart';
import 'package:flutter_example_test/animation/animation.dart';
import 'package:flutter_example_test/async/async.dart';
import 'package:flutter_example_test/todo/providers/todo_provider.dart';
import 'package:flutter_example_test/todo/todo.dart';
import 'package:provider/provider.dart';

void main() async {
  // MARK: - TODO
  // WidgetsFlutterBinding.ensureInitialized();
  // final todosProvider = TodosProvider();
  // await todosProvider.loadTodos(); // Todo 항목 불러오기
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => todosProvider,
  //     child: const TodoApp(),
  //   ),
  // );

  // MARK: - ANIMATION
  // runApp(const AnimationExampleApp());

  // MARK: - ASYNC
  runApp(const AsyncExampleApp());
}
