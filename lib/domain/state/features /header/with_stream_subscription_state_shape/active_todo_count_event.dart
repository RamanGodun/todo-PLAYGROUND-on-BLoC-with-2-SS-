part of 'active_todo_count_bloc.dart';

/// 📌 **[ActiveTodoCountEventWithStreamSubscriptionStateShape] - Base class for active ToDo count events.**
/// - Defines events used in **Stream Subscription-Based State Shape**.
sealed class ActiveTodoCountEventWithStreamSubscriptionStateShape
    extends Equatable {
  const ActiveTodoCountEventWithStreamSubscriptionStateShape();

  @override
  List<Object> get props => [];
}

/// 🔢 **[CalculateActiveTodoCountEvent] - Triggers active ToDo count calculation.**
/// - Fired when the count of active ToDos changes in **TodoListBloc**.
/// - Ensures UI updates with the latest active task count.
final class CalculateActiveTodoCountEvent
    extends ActiveTodoCountEventWithStreamSubscriptionStateShape {
  final int activeTodoCount;

  const CalculateActiveTodoCountEvent({required this.activeTodoCount});

  @override
  String toString() =>
      'CalculateActiveTodoCountEvent(activeTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];
}
