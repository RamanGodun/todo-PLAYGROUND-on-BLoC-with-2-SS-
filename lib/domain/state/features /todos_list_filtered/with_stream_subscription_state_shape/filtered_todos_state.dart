part of 'filtered_todos_bloc.dart';

/// 📌 **[FilteredTodosStateOnBlocWithStreamSubscriptionStateShape]**
/// - Represents the state of **filtered ToDos** for **Stream Subscription-Based State Shape**.
final class FilteredTodosStateOnBlocWithStreamSubscriptionStateShape
    extends Equatable {
  final List<Todo> filteredTodos;

  const FilteredTodosStateOnBlocWithStreamSubscriptionStateShape({
    required this.filteredTodos,
  });

  /// 🔄 **Returns the initial state (empty filtered list).**
  factory FilteredTodosStateOnBlocWithStreamSubscriptionStateShape.initial() {
    return const FilteredTodosStateOnBlocWithStreamSubscriptionStateShape(
        filteredTodos: []);
  }

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodosState(filteredTodos: $filteredTodos)';

  /// ✏️ **Creates a copy of the state with updated properties.**
  FilteredTodosStateOnBlocWithStreamSubscriptionStateShape copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosStateOnBlocWithStreamSubscriptionStateShape(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}
