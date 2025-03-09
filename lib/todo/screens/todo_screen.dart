import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/providers/todo_provider.dart';
import 'package:flutter_example_test/todo/widgets/todo_add_dialog.dart';
import 'package:flutter_example_test/todo/widgets/todo_delete_dialog.dart';
import 'package:flutter_example_test/todo/widgets/todo_edit_dialog.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const TodoAddDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosProvider>(
      builder: (context, todos, child) {
        if (todos.todos.isEmpty) {
          return const Center(
            child: Text('할 일이 없습니다. 새 할 일을 추가해보세요!'),
          );
        }
        return ListView.builder(
          itemCount: todos.todos.length,
          itemBuilder: (context, index) {
            final todo = todos.todos[index];
            return ListTile(
              title: Text(todo.title),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => TodoEditDialog(todo: todo),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => TodoDeleteDialog(todo: todo),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
