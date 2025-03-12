import 'package:flutter/material.dart';
import '../../ui/widgets/alert_dialogs/create_todo.dart';
import '../../ui/widgets/alert_dialogs/edit_todo.dart';
import '../models/todo_model.dart';

/// 💬 **[DialogService] - A centralized service for managing app dialogs.**
/// - Provides reusable dialogs for **creating, editing, and loading states**.
/// - Ensures a **consistent UI/UX** across the application.
abstract class DialogService {
  /// 📝 **Opens a dialog for creating a new ToDo.**
  static void showCreateTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CreateTodoDialog(),
    );
  }

  /// 🔄 **Displays a loading dialog with a centered `CircularProgressIndicator`.**
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // ❌ Prevents unintended dismissals
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// ❌ **Closes any currently open dialogs.**
  static void closeDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// ✏️ **Opens a dialog for editing an existing ToDo.**
  static void editTodo(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (context) => EditTodoDialog(todo: todo),
    );
  }
}
