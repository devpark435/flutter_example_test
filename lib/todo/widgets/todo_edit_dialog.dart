import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/models/todo_model.dart';
import 'package:flutter_example_test/todo/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoEditDialog extends StatefulWidget {
  final Todo todo;
  const TodoEditDialog({super.key, required this.todo});

  @override
  State<TodoEditDialog> createState() => _TodoEditDialogState();
}

class _TodoEditDialogState extends State<TodoEditDialog> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('할 일 수정'),
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
            context
                .read<TodosProvider>()
                .editTodo(widget.todo.id, titleController.text);
            Navigator.of(context).pop();
          },
          child: const Text('수정'),
        ),
      ],
    );
  }
}
