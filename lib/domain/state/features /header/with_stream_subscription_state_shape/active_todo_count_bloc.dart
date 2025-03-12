import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/todo_model.dart';
import '../../todos_list/todo_list_bloc.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

/// 📊 **[ActiveTodoCountBlocWithStreamSubscriptionStateShape] - Tracks the number of active (incomplete) ToDos.**
/// - Uses **Stream Subscription-Based State Shape**.
/// - Listens for changes in the **TodoListBloc** state and updates automatically.
class ActiveTodoCountBlocWithStreamSubscriptionStateShape extends Bloc<
    ActiveTodoCountEventWithStreamSubscriptionStateShape,
    ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape> {
  final TodoListBloc todoListBloc;

  /// 🆕 **Initializes the BLoC and subscribes to `TodoListBloc` changes.**
  ActiveTodoCountBlocWithStreamSubscriptionStateShape({
    required this.todoListBloc,
  }) : super(ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape(
          activeTodoCount: _calculateInitialActiveTodos(todoListBloc.state),
        )) {
    /// 🔄 **Handles incoming events for active ToDo count updates.**
    on<CalculateActiveTodoCountEvent>(_onCalculate);

    /// 🎧 **Subscribes to `TodoListBloc` state changes.**
    /// - Whenever the ToDo list updates, it recalculates the active ToDo count.
    /// - Only triggers a state change if the count has changed.
    todoListBloc.stream.listen((TodoListStateOnBloc todoListState) {
      final int currentActiveTodoCount =
          todoListState.todos.where((Todo todo) => !todo.completed).length;

      if (currentActiveTodoCount != state.activeTodoCount) {
        add(CalculateActiveTodoCountEvent(
            activeTodoCount: currentActiveTodoCount));
      }
    });
  }

  /// 🔢 **Calculates the initial active ToDo count from `TodoListBloc`.**
  static int _calculateInitialActiveTodos(TodoListStateOnBloc todoListState) {
    return todoListState.todos.where((Todo todo) => !todo.completed).length;
  }

  /// 🚀 **Handles the calculation event and updates the state.**
  void _onCalculate(
    CalculateActiveTodoCountEvent event,
    Emitter<ActiveTodoCountStateOnBlocWithStreamSubscriptionStateShape> emit,
  ) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }
}
