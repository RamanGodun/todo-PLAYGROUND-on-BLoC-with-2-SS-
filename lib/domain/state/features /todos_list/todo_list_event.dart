part of 'todo_list_bloc.dart';

/// 🎭 **[TodoListEventOnBloc] - Defines events for [TodoListBloc].**
sealed class TodoListEventOnBloc extends Equatable {
  const TodoListEventOnBloc();

  @override
  List<Object> get props => [];
}

/// ➕ **[AddTodoEvent] - Adds a new ToDo to the list.**
class AddTodoEvent extends TodoListEventOnBloc {
  /// 📝 **Description of the new ToDo.**
  final String todoDesc;

  /// 🆕 **Constructor** - Requires a `todoDesc`.
  const AddTodoEvent({
    required this.todoDesc,
  });

  @override
  String toString() => 'AddTodoEvent(todoDesc: $todoDesc)';

  @override
  List<Object> get props => [todoDesc];
}

/// ✏️ **[EditTodoEvent] - Edits an existing ToDo.**
class EditTodoEvent extends TodoListEventOnBloc {
  /// 🆔 **Unique ID of the ToDo being edited.**
  final String id;

  /// 📝 **Updated description for the ToDo.**
  final String todoDesc;

  /// 🆕 **Constructor** - Requires `id` and `todoDesc`.
  const EditTodoEvent({
    required this.id,
    required this.todoDesc,
  });

  @override
  String toString() => 'EditTodoEvent(id: $id, todoDesc: $todoDesc)';

  @override
  List<Object> get props => [id, todoDesc];
}

/// ✅ **[ToggleTodoEvent] - Toggles the completion status of a ToDo.**
class ToggleTodoEvent extends TodoListEventOnBloc {
  /// 🆔 **Unique ID of the ToDo being toggled.**
  final String id;

  /// 🆕 **Constructor** - Requires `id`.
  const ToggleTodoEvent({
    required this.id,
  });

  @override
  String toString() => 'ToggleTodoEvent(id: $id)';

  @override
  List<Object> get props => [id];
}

/// ❌ **[RemoveTodoEvent] - Removes a ToDo from the list.**
class RemoveTodoEvent extends TodoListEventOnBloc {
  /// 📝 **ToDo item to be removed.**
  final Todo todo;

  /// 🆕 **Constructor** - Requires `todo`.
  const RemoveTodoEvent({
    required this.todo,
  });

  @override
  String toString() => 'RemoveTodoEvent(todo: $todo)';

  @override
  List<Object> get props => [todo];
}
