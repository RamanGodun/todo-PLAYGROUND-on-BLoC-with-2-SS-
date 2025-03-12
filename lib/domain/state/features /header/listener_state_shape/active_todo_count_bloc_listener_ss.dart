import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/todo_model.dart';
import '../../../../utils_and_services/bloc_exports.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBlocWithListenerStateShape extends Bloc<
    ActiveTodoCountEventWithListenerStateShape,
    ActiveTodoCountStateOnBlocWithListenerStateShape> {
  final TodoListBloc todoListBloc;

  ActiveTodoCountBlocWithListenerStateShape({required this.todoListBloc})
      : super(ActiveTodoCountStateOnBlocWithListenerStateShape(
            activeTodoCount: _calculateInitialActiveTodos(todoListBloc))) {
    on<CalculateActiveTodoCountEventWithListenerStateShape>(_onCalculate);
  }

  static int _calculateInitialActiveTodos(TodoListBloc todoListBloc) {
    return todoListBloc.state.todos
        .where((Todo todo) => !todo.completed)
        .length;
  }

  void _onCalculate(
    CalculateActiveTodoCountEventWithListenerStateShape event,
    Emitter<ActiveTodoCountStateOnBlocWithListenerStateShape> emit,
  ) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }
}
