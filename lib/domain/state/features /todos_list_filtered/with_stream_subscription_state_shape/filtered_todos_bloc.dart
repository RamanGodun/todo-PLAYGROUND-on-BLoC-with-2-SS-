import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../models/enums.dart';
import '../../../../models/todo_model.dart';
import '../../todo_filter/todo_filter_bloc.dart';
import '../../todo_search/todo_search_bloc.dart';
import '../../todos_list/todo_list_bloc.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

/// 📌 **[FilteredTodosBlocWithStreamSubscriptionStateShape]**
/// - Manages **filtered ToDos** using a **Stream Subscription-Based State Shape**.
/// - **Listens to multiple state streams** (TodoList, TodoFilter, TodoSearch).
/// - **Updates state dynamically** as changes occur.
class FilteredTodosBlocWithStreamSubscriptionStateShape extends Bloc<
    FilteredTodosEventWithStreamSubscriptionStateShape,
    FilteredTodosStateOnBlocWithStreamSubscriptionStateShape> {
  /// 📡 **Stream Subscriptions** to listen for state changes.
  late StreamSubscription todoFilterSubscription;
  late StreamSubscription todoSearchSubscription;
  late StreamSubscription todoListSubscription;

  /// 📋 **Initial ToDos list.**
  final List<Todo> initialTodos;

  /// 🔄 **Bloc dependencies for filtering and searching.**
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;

  /// 🆕 **Constructor**
  /// - Initializes with provided **ToDo list**, **filter**, and **search state**.
  FilteredTodosBlocWithStreamSubscriptionStateShape({
    required this.initialTodos,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.todoListBloc,
  }) : super(FilteredTodosStateOnBlocWithStreamSubscriptionStateShape(
          filteredTodos: initialTodos,
        )) {
    /// 🎯 **Listens for filter changes** and updates filtered ToDos.
    todoFilterSubscription =
        todoFilterBloc.stream.listen((TodoFilterStateOnBloc todoFilterState) {
      _setFilteredTodos();
    });

    /// 🔍 **Listens for search term updates** and updates the filtered list.
    todoSearchSubscription =
        todoSearchBloc.stream.listen((TodoSearchStateOnBloc todoSearchState) {
      _setFilteredTodos();
    });

    /// 📌 **Listens for ToDo list changes** and applies filtering.
    todoListSubscription =
        todoListBloc.stream.listen((TodoListStateOnBloc todoListState) {
      _setFilteredTodos();
    });

    /// 🔄 **Handles state updates based on computed filtered ToDos.**
    on<CalculateFilteredTodosEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }

  /// 🔄 **Filters ToDos based on the active filter and search term.**
  void _setFilteredTodos() {
    List<Todo> filteredTodos;

    /// 📌 **Applies active filter** (All, Active, Completed).
    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        filteredTodos = todoListBloc.state.todos
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        filteredTodos = todoListBloc.state.todos
            .where((Todo todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
        filteredTodos = todoListBloc.state.todos;
        break;
    }

    /// 🔍 **Applies search term filtering.**
    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchBloc.state.searchTerm.toLowerCase()))
          .toList();
    }

    /// 🚀 **Dispatches event to update the filtered ToDo state.**
    add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
  }

  /// 🛑 **Closes all active stream subscriptions** to prevent memory leaks.
  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }
}
