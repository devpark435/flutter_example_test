import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/models/todo_model.dart';
import 'package:flutter_example_test/todo/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoAddDialog extends StatefulWidget {
  const TodoAddDialog({super.key});

  @override
  State<TodoAddDialog> createState() => _TodoAddDialogState();
}

class _TodoAddDialogState extends State<TodoAddDialog> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();

    return AlertDialog(
      title: const Text('할 일 추가'),
      content: TextField(
        controller: titleController,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            context.read<TodosProvider>().addTodo(Todo(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                ));
            Navigator.of(context).pop();
          },
          child: const Text('추가'),
        ),
      ],
    );
  }
}
