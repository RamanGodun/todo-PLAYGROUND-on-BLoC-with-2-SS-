import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/todo_model.dart';
import '../../../../utils_and_services/bloc_exports.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

/// 🔢 **[ActiveTodoCountBlocWithListenerStateShape] - BLoC for tracking active ToDo count.**
/// - Uses **Listener-Based State Shape**.
/// - Monitors the **TodoListBloc** to update the count of active (incomplete) tasks.
class ActiveTodoCountBlocWithListenerStateShape extends Bloc<
    ActiveTodoCountEventWithListenerStateShape,
    ActiveTodoCountStateOnBlocWithListenerStateShape> {
  final TodoListBloc todoListBloc;

  /// 🆕 **Initializes the Active ToDo Counter.**
  /// - Subscribes to **TodoListBloc** for changes.
  /// - Computes **initial count** of active ToDos.
  ActiveTodoCountBlocWithListenerStateShape({required this.todoListBloc})
      : super(ActiveTodoCountStateOnBlocWithListenerStateShape(
            activeTodoCount: _calculateInitialActiveTodos(todoListBloc))) {
    on<CalculateActiveTodoCountEventWithListenerStateShape>(_onCalculate);
  }

  /// 🔢 **Calculates the initial number of active (incomplete) ToDos.**
  static int _calculateInitialActiveTodos(TodoListBloc todoListBloc) {
    return todoListBloc.state.todos
        .where((Todo todo) => !todo.completed)
        .length;
  }

  /// 🔄 **Handles event to update the active ToDo count.**
  ///
  /// Emits a **new state** with the updated count.
  void _onCalculate(
    CalculateActiveTodoCountEventWithListenerStateShape event,
    Emitter<ActiveTodoCountStateOnBlocWithListenerStateShape> emit,
  ) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }
}
