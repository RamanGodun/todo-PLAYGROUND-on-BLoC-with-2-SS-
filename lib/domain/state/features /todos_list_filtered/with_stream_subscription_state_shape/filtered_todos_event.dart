part of 'filtered_todos_bloc.dart';

/// 🎭 **[FilteredTodosEventWithStreamSubscriptionStateShape]**
/// - Defines events for [FilteredTodosBlocWithStreamSubscriptionStateShape].
sealed class FilteredTodosEventWithStreamSubscriptionStateShape
    extends Equatable {
  const FilteredTodosEventWithStreamSubscriptionStateShape();

  @override
  List<Object> get props => [];
}

/// 🔄 **[CalculateFilteredTodosEvent] - Updates the filtered ToDo list.**
class CalculateFilteredTodosEvent
    extends FilteredTodosEventWithStreamSubscriptionStateShape {
  final List<Todo> filteredTodos;

  const CalculateFilteredTodosEvent({required this.filteredTodos});

  @override
  String toString() =>
      'CalculateFilteredTodosEvent(filteredTodos: $filteredTodos)';

  @override
  List<Object> get props => [filteredTodos];
}
