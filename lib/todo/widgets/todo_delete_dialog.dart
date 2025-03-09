import 'package:flutter/material.dart';
import 'package:flutter_example_test/todo/providers/todo_provider.dart';
import 'package:flutter_example_test/todo/models/todo_model.dart';
import 'package:provider/provider.dart';

class TodoDeleteDialog extends StatefulWidget {
  final Todo todo;
  const TodoDeleteDialog({super.key, required this.todo});

  @override
  State<TodoDeleteDialog> createState() => _TodoDeleteDialogState();
}

class _TodoDeleteDialogState extends State<TodoDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('할 일 삭제'),
      content: const Text('정말로 삭제하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            context.read<TodosProvider>().deleteTodo(widget.todo.id);
            Navigator.of(context).pop();
          },
          child: const Text('삭제'),
        ),
      ],
    );
  }
}
