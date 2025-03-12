import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/app_constants/app_strings.dart';
import '../../../domain/models/todo_model.dart';
import '../../../domain/state/features /todos_list/todo_list_bloc.dart';
import '../../../domain/utils_and_services/helpers.dart';
import '../text_widget.dart';

/// ✏️ **[EditTodoDialog] - Dialog for editing an existing ToDo.**
/// - Uses **[HookWidget]** for efficient state management.
class EditTodoDialog extends HookWidget {
  final Todo todo;
  const EditTodoDialog({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    /// 🎨 **Retrieves the theme-aware color scheme.**
    final colorScheme = Helpers.getColorScheme(context);

    /// 📝 **Text controller** for editing the ToDo description.
    final textController = useTextEditingController(text: todo.desc);

    return AlertDialog(
      title: const TextWidget(AppStrings.editTodoTitle, TextType.smallHeadline),
      content: TextField(
        controller: textController,
        style: Helpers.getTextTheme(context).titleLarge,
        decoration:
            const InputDecoration(labelText: AppStrings.newTodoDescription),
        autofocus: true,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// ❌ **Cancel Button** - Closes the dialog without saving changes.
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: TextWidget(
                AppStrings.cancelButton,
                TextType.button,
                color: colorScheme.error,
              ),
            ),

            /// 💾 **Save Button** - Updates the ToDo and closes the dialog.
            TextButton(
              onPressed: () {
                final newDesc = textController.text.trim();
                if (newDesc.isNotEmpty) {
                  context
                      .read<TodoListBloc>()
                      .add(EditTodoEvent(id: todo.id, todoDesc: newDesc));
                  Navigator.of(context).pop();
                }
              },
              child: TextWidget(
                AppStrings.saveButton,
                TextType.button,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
