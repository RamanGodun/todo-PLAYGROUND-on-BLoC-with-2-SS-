part of 'filtered_todos_bloc_listener_ss.dart';

/// 🎭 **[FilteredTodosEventWithListenerStateShape] - Defines events for [FilteredTodosBlocWithListenerStateShape].**
sealed class FilteredTodosEventWithListenerStateShape extends Equatable {
  const FilteredTodosEventWithListenerStateShape();

  @override
  List<Object> get props => [];
}

/// 🔄 **[CalculateFilteredTodosEventWithListenerStateShape] - Updates the filtered ToDos list.**
class CalculateFilteredTodosEventWithListenerStateShape
    extends FilteredTodosEventWithListenerStateShape {
  /// 📋 **Filtered list of ToDos.**
  final List<Todo> filteredTodos;

  /// 🆕 **Constructor** - Requires `filteredTodos`.
  const CalculateFilteredTodosEventWithListenerStateShape({
    required this.filteredTodos,
  });

  @override
  String toString() =>
      'CalculateFilteredTodosEvent(filteredTodos: $filteredTodos)';

  @override
  List<Object> get props => [filteredTodos];
}
