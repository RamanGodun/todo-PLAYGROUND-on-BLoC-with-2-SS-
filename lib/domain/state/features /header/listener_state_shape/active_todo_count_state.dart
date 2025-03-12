part of 'active_todo_count_bloc_listener_ss.dart';

/// 📊 **[ActiveTodoCountStateOnBlocWithListenerStateShape] - Represents the state of active ToDo count.**
/// - Stores the **number of active (incomplete) tasks**.
/// - Used in **Listener-Based State Shape**.
final class ActiveTodoCountStateOnBlocWithListenerStateShape extends Equatable {
  /// 🔢 **Current count of active (incomplete) ToDos.**
  final int activeTodoCount;

  /// 🆕 **Creates a new state with the given active ToDo count.**
  const ActiveTodoCountStateOnBlocWithListenerStateShape({
    required this.activeTodoCount,
  });

  /// 🔄 **Returns the initial state with `0` active ToDos.**
  factory ActiveTodoCountStateOnBlocWithListenerStateShape.initial() {
    return const ActiveTodoCountStateOnBlocWithListenerStateShape(
        activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  @override
  String toString() =>
      'ActiveTodoCountState(activeTodoCount: $activeTodoCount)';

  /// 🔄 **Creates a new state with updated properties.**
  ActiveTodoCountStateOnBlocWithListenerStateShape copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountStateOnBlocWithListenerStateShape(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}
