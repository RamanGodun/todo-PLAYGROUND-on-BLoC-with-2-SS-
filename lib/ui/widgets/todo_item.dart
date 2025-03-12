import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_constants/app_strings.dart';
import '../../domain/models/todo_model.dart';
import '../../domain/utils_and_services/bloc_exports.dart';
import '../../domain/utils_and_services/dialogs_service.dart';
import '../../domain/utils_and_services/helpers.dart';

/// 🎯 **[SlidableTodoItem]** - A `TodoItem` wrapped with swipe actions.
/// Allows users to **edit** or **delete** a ToDo item via swipe gestures.
class SlidableTodoItem extends StatelessWidget {
  final Todo todo;
  const SlidableTodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Helpers.getColorScheme(context);

    return Slidable(
      key: ValueKey(todo.id),

      /// 🟦 **Left Swipe: Edit Action**
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => DialogService.editTodo(context, todo),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            label: AppStrings.editButton,
          ),
        ],
      ),

      /// 🟥 **Right Swipe: Delete Action**
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) =>
                context.read<TodoListBloc>().add(RemoveTodoEvent(todo: todo)),
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            icon: Icons.delete,
            label: AppStrings.deleteButton,
          ),
        ],
      ),

      /// 📌 **Main ToDo Item**
      child: TodoItem(todo: todo),
    );
  }
}

/// ✅ **[TodoItem]** - A single ToDo item in the list.
/// Displays the **checkbox** and **ToDo description**.
class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final textColor = Helpers.getColorScheme(context).onSurface;
    return ListTile(
      leading: Checkbox(
          value: todo.completed,
          onChanged: (_) =>
              context.read<TodoListBloc>().add(ToggleTodoEvent(id: todo.id))),
      title: Text(
        todo.desc,
        style: TextStyle(
          decoration: todo.completed ? TextDecoration.lineThrough : null,
          color: todo.completed ? textColor.withOpacity(0.5) : textColor,
        ),
      ),
    );
  }
}
