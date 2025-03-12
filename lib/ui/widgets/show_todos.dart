import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/app_constants/app_constants.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/todo_model.dart';
import '../../domain/utils_and_services/bloc_exports.dart';
import 'todo_item.dart';

/// 📌 [ShowTodosWidget] - A dynamic widget that displays ToDo items.
/// Depending on the selected **State Shape** (Listener-Based / Stream Subscription-Based),
/// it chooses the appropriate method to handle state updates.
class ShowTodosWidget extends StatelessWidget {
  const ShowTodosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// 🔄 Retrieves the current **State Shape Mode** from [AppSettingsCubit].
    final isListenerBasedStateShape = context.select<AppSettingsBloc, bool>(
      (cubit) => cubit.state.isUsingListenerStateShapeForAppFeatures,
    );

    return isListenerBasedStateShape
        ? const ShowTodosWithListenerStateShape()
        : const ShowTodosForStreamSubscriptionStateShape();
  }
}

/// ! 🔵 [ShowTodosForStreamSubscriptionStateShape] - Displays ToDos using **Stream Subscription-Based State Shape**.
/// It listens for updates from **FilteredTodosCubitWithStreamSubscriptionStateShape**.
class ShowTodosForStreamSubscriptionStateShape extends StatelessWidget {
  const ShowTodosForStreamSubscriptionStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context
        .watch<FilteredTodosBlocWithStreamSubscriptionStateShape>()
        .state
        .filteredTodos;

    return _buildTodoList(context, todos);
  }
}

/// ! 🟠 [ShowTodosWithListenerStateShape] - Displays ToDos using **Listener-Based State Shape**.
/// It uses multiple **BlocListener** instances to update the filtered ToDos list.
class ShowTodosWithListenerStateShape extends StatelessWidget {
  const ShowTodosWithListenerStateShape({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context
        .watch<FilteredTodosBlocWithListenerStateShape>()
        .state
        .filteredTodos;

    return MultiBlocListener(
      listeners: [
        /// 🎯 Listens for changes in the ToDo list and updates the filtered list.
        BlocListener<TodoListBloc, TodoListStateOnBloc>(
          listener: (context, state) {
            _updateFilteredTodos(context, state.todos);
          },
        ),

        /// 🔍 Listens for filter changes and updates the filtered ToDos list.
        BlocListener<TodoFilterBloc, TodoFilterStateOnBloc>(
          listener: (context, state) {
            _updateFilteredTodos(
                context, context.read<TodoListBloc>().state.todos);
          },
        ),

        /// 🔎 Listens for search term changes and updates the filtered ToDos list.
        BlocListener<TodoSearchBloc, TodoSearchStateOnBloc>(
          listener: (context, state) {
            _updateFilteredTodos(
                context, context.read<TodoListBloc>().state.todos);
          },
        ),
      ],
      child: _buildTodoList(context, todos),
    );
  }

  /// 🛠 **Updates the filtered ToDos based on filter and search criteria.**
  void _updateFilteredTodos(BuildContext context, List<Todo> allTodos) {
    final filter = context.read<TodoFilterBloc>().state.filter;
    final searchTerm = context.read<TodoSearchBloc>().state.searchTerm;

    final filteredTodos = allTodos.where((todo) {
      final matchesFilter = filter == Filter.all ||
          (filter == Filter.active && !todo.completed) ||
          (filter == Filter.completed && todo.completed);

      final matchesSearch = searchTerm.isEmpty ||
          todo.desc.toLowerCase().contains(searchTerm.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();

    context.read<FilteredTodosBlocWithListenerStateShape>().add(
        CalculateFilteredTodosEventWithListenerStateShape(
            filteredTodos: filteredTodos));
  }
}

/// 🔧 [_buildTodoList] - Builds a list of **SlidableTodoItem** widgets.
Widget _buildTodoList(BuildContext context, List<Todo> todos) {
  return ListView.separated(
    primary: false,
    shrinkWrap: true,
    itemCount: todos.length,
    separatorBuilder: (BuildContext context, int index) {
      return const Divider(
        color: AppConstants.darkSurfaceColor,
        thickness: 0.5,
      );
    },
    itemBuilder: (BuildContext context, int index) {
      return SlidableTodoItem(todo: todos[index]);
    },
  );
}
