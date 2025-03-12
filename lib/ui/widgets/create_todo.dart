import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/app_constants/app_constants.dart';
import '../../domain/app_constants/app_strings.dart';
import '../../domain/state/features /todos_list/todo_list_bloc.dart';
import '../../domain/utils_and_services/helpers.dart';
import 'text_widget.dart';

/// 📜 [CreateTodoDialog] - A dialog for adding a new ToDo task.
/// Uses [HookWidget] for state management with [useTextEditingController].
class CreateTodoDialog extends HookWidget {
  const CreateTodoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // 📝 Controller for entering new ToDo description.
    final newTodoController = useTextEditingController();

    return AlertDialog(
      title: const TextWidget(AppStrings.newTodoTitle, TextType.smallHeadline),
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
                /// 🖊️ Text field for entering the ToDo description.
                TextField(
                  style: Helpers.getTextTheme(context).titleLarge,
                  controller: newTodoController,
                  decoration: const InputDecoration(
                      labelText: AppStrings.todoInputHint),
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
            /// ❌ Cancel button - Closes the dialog without adding a ToDo.
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const TextWidget(
                AppStrings.cancelButton,
                TextType.titleSmall,
                color: AppConstants.errorColor,
              ),
            ),

            /// ✅ Add button - Saves the new ToDo and closes the dialog.
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
              child: const TextWidget(
                AppStrings.addButton,
                TextType.button,
                color: AppConstants.darkPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
