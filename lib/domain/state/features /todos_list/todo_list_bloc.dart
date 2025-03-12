import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/todo_model.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

/// 📌 **[TodoListBloc] - Manages ToDo operations and state persistence.**
/// - **Supports CRUD operations:** Add, Edit, Toggle, and Remove.
/// - **HydratedBloc-powered persistence:** Automatically saves and restores state.
/// - **Implements the `fromJson` and `toJson` methods** for state persistence.

class TodoListBloc
    extends HydratedBloc<TodoListEventOnBloc, TodoListStateOnBloc> {
  /// 🆕 **Initializes the Bloc with an empty ToDo list or a restored state.**
  TodoListBloc() : super(TodoListStateOnBloc.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  /// ➕ **Handles adding a new ToDo.**
  void _addTodo(AddTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodo = Todo(desc: event.todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
  }

  /// ✏️ **Handles editing an existing ToDo.**
  void _editTodo(EditTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return todo.copyWith(desc: event.todoDesc);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  /// ✅ **Handles toggling a ToDo's completion state.**
  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todos: newTodos));
  }

  /// ❌ **Handles removing a ToDo from the list.**
  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListStateOnBloc> emit) {
    final newTodos =
        state.todos.where((Todo t) => t.id != event.todo.id).toList();
    emit(state.copyWith(todos: newTodos));
  }

  /// 💾 **Restores the state from JSON after app restart.**
  @override
  TodoListStateOnBloc? fromJson(Map<String, dynamic> json) {
    try {
      final todos = (json['todos'] as List<dynamic>?)
          ?.map((e) => Todo.fromMap(e as Map<String, dynamic>))
          .whereType<Todo>()
          .toList();
      return todos != null && todos.isNotEmpty
          ? TodoListStateOnBloc(todos: todos)
          : TodoListStateOnBloc.initial();
    } catch (_) {
      return TodoListStateOnBloc.initial();
    }
  }

  /// 💾 **Serializes the state to JSON for persistence.**
  @override
  Map<String, dynamic>? toJson(TodoListStateOnBloc state) {
    try {
      return {'todos': state.todos.map((e) => e.toMap()).toList()};
    } catch (_) {
      return null;
    }
  }
}
