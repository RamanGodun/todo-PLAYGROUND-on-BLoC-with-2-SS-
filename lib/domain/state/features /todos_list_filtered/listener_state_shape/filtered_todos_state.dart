part of 'filtered_todos_bloc_listener_ss.dart';

/// 📌 **[FilteredTodosStateOnBlocWithListenerStateShape] - Represents the state of filtered ToDos.**
final class FilteredTodosStateOnBlocWithListenerStateShape extends Equatable {
  /// 📋 **List of filtered ToDos in the current state.**
  final List<Todo> filteredTodos;

  /// 🆕 **Constructor** - Requires `filteredTodos`.
  const FilteredTodosStateOnBlocWithListenerStateShape({
    required this.filteredTodos,
  });

  /// 🔄 **Returns the initial state (empty filtered list).**
  factory FilteredTodosStateOnBlocWithListenerStateShape.initial() {
    return const FilteredTodosStateOnBlocWithListenerStateShape(
        filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  /// ✏️ **Creates a copy of the state with updated properties.**
  FilteredTodosStateOnBlocWithListenerStateShape copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosStateOnBlocWithListenerStateShape(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
