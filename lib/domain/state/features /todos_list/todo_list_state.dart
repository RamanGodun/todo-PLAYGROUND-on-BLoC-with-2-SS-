part of 'todo_list_bloc.dart';

/// 📌 **[TodoListStateOnBloc] - Represents the current state of the ToDo list.**
final class TodoListStateOnBloc extends Equatable {
  /// 📋 **List of ToDos in the current state.**
  final List<Todo> todos;

  /// 🆕 **Constructor** - Requires a list of `todos`.
  const TodoListStateOnBloc({required this.todos});

  /// 🔄 **Returns the initial empty state.**
  factory TodoListStateOnBloc.initial() {
    return const TodoListStateOnBloc(todos: []);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoListState(todos: $todos)';

  /// ✏️ **Creates a copy of the state with updated properties.**
  TodoListStateOnBloc copyWith({
    List<Todo>? todos,
  }) {
    return TodoListStateOnBloc(
      todos: todos ?? this.todos,
    );
  }
}
