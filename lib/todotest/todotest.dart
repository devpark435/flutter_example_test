import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodotestApp extends StatelessWidget {
  const TodotestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TodoScreen 예제',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Test'),
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) => const TodoAddDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, todos, child) {
      return ListView.builder(
        itemCount: todos.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos.todos[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => TodoEditDialog(index: index),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    context.read<TodoProvider>().deleteTodo(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

class TodoAddDialog extends StatelessWidget {
  const TodoAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      title: Text('Todo 추가'),
      content: TextField(
        controller: controller,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<TodoProvider>().addTodo(controller.text);
            Navigator.pop(context);
          },
          child: Text('추가'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
      ],
    );
  }
}

class TodoEditDialog extends StatelessWidget {
  final int index;
  const TodoEditDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      title: Text('Todo 수정'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: context.read<TodoProvider>().todos[index],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<TodoProvider>().editTodo(index, controller.text);
            Navigator.pop(context);
          },
          child: Text('수정'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
      ],
    );
  }
}

class TodoProvider extends ChangeNotifier {
  final List<String> _todos = [];

  List<String> get todos => _todos;

  void addTodo(String todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void editTodo(int index, String todo) {
    _todos[index] = todo;
    notifyListeners();
  }
}
