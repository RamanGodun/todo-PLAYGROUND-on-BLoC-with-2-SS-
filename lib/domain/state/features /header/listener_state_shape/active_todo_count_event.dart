part of 'active_todo_count_bloc_listener_ss.dart';

/// 📌 **[ActiveTodoCountEventWithListenerStateShape] - Events for Active ToDo Count BLoC.**
/// - Defines actions related to updating the **active ToDo count**.
/// - Used in **Listener-Based State Shape**.
sealed class ActiveTodoCountEventWithListenerStateShape extends Equatable {
  const ActiveTodoCountEventWithListenerStateShape();

  @override
  List<Object> get props => [];
}

/// 🔢 **[CalculateActiveTodoCountEventWithListenerStateShape] - Event to update active ToDo count.**
/// - Triggers a recalculation of the number of **incomplete tasks**.
/// - Dispatched when the **ToDo list changes**.
final class CalculateActiveTodoCountEventWithListenerStateShape
    extends ActiveTodoCountEventWithListenerStateShape {
  /// 📊 **Updated count of active (incomplete) ToDos.**
  final int activeTodoCount;

  /// 🆕 **Creates an event with the new active ToDo count.**
  const CalculateActiveTodoCountEventWithListenerStateShape({
    required this.activeTodoCount,
  });

  @override
  String toString() =>
      'CalculateActiveTodoCountEvent(activeTodoCount: $activeTodoCount)';

  @override
  List<Object> get props => [activeTodoCount];
}
