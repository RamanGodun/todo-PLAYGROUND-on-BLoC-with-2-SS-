import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_constants/app_constants.dart';
import '../../domain/app_constants/app_strings.dart';
import '../../domain/state/app_settings/app_settings_bloc.dart';
import '../../domain/utils_and_services/dialogs_service.dart';
import '../../domain/utils_and_services/helpers.dart';
import '../../domain/utils_and_services/overlay_service.dart';
import '../widgets/search_and_filter_todo.dart';
import '../widgets/show_todos.dart';
import '../widgets/todo_header.dart';

part 'state_shape_toggle_icon.dart';
part 'theme_toggle_icon.dart';

/// 🏠 **[HomePage] - Main Screen of the Application**
/// - Provides UI for toggling **Theme Mode** (Light / Dark).
/// - Allows switching between **State Shape Modes** (`Listener-Based` / `Stream Subscription-Based`).
/// - Displays a **ToDo List** with filtering and search functionality.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 45),
            child: TodoHeader(),
          ),
          actions: const [
            ThemeToggleIcon(),
            StateShapeToggleIcon(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: const [
              SizedBox(height: 20.0),
              SearchAndFilterTodo(),
              ShowTodosWidget(),
            ],
          ),
        ),
        floatingActionButton: const AddTodoFAB(),
      ),
    );
  }
}

/// ➕ **[AddTodoFAB] - Floating Action Button for Creating New ToDo**
class AddTodoFAB extends StatelessWidget {
  const AddTodoFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100, right: 10),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Helpers.getColorScheme(context).primary,
        onPressed: () => DialogService.showCreateTodoDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
