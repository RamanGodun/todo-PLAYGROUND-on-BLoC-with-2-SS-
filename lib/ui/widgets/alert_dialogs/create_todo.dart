import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/app_constants/app_constants.dart';
import '../../../domain/app_constants/app_strings.dart';
import '../../../domain/state/features /todos_list/todo_list_bloc.dart';
import '../../../domain/utils_and_services/helpers.dart';
import '../text_widget.dart';

/// 📜 **[CreateTodoDialog] - Dialog for adding a new ToDo task.**
/// - Uses **[HookWidget]** for efficient state management.
class CreateTodoDialog extends HookWidget {
  const CreateTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    /// 📝 **Text controller** for entering the ToDo description.
    final newTodoController = useTextEditingController();
    final colorScheme = Helpers.getColorScheme(context);

    return AlertDialog(
      title: TextWidget(
        AppStrings.newTodoTitle,
        TextType.smallHeadline,
        color: colorScheme.onSurface.withOpacity(0.7),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height *
              AppConstants.dialogMaxHeightRatio,
        ),
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🖊 **Text field for ToDo description input.**
                TextField(
                  style: Helpers.getTextTheme(context).titleLarge,
                  controller: newTodoController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.todoInputHint,
                  ),
                  autofocus: true,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// ❌ **Cancel Button** - Closes the dialog without saving.
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: TextWidget(
                AppStrings.cancelButton,
                TextType.button,
                color: colorScheme.error,
              ),
            ),

            /// ✅ **Add Button** - Saves the new ToDo and closes the dialog.
            TextButton(
              onPressed: () {
                final todoDesc = newTodoController.text.trim();

                if (todoDesc.isNotEmpty) {
                  context
                      .read<TodoListBloc>()
                      .add(AddTodoEvent(todoDesc: todoDesc));
                  Navigator.of(context).pop();
                }
              },
              child: TextWidget(
                AppStrings.addButton,
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
