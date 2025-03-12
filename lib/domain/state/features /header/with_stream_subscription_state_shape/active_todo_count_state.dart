part of 'active_todo_count_bloc.dart';

/// 📊 **[ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape] - Represents the state for active ToDo count.**
/// - Used in **Stream Subscription-Based State Shape**.
/// - Stores the current count of active (incomplete) ToDos.
final class ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape
    extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape({
    required this.activeTodoCount,
  });

  /// 🏁 **Initial State Factory**
  /// - Sets **active ToDo count** to `0` by default.
  factory ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape.initial() {
    return const ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
        activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  /// 🔄 **Creates a copy of the state with updated properties.**
  ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
