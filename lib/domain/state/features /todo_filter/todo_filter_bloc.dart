import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/enums.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

/// 🎯 **[TodoFilterBloc] - Manages the filtering of ToDo items.**
/// - Allows switching between different filter modes (`All`, `Active`, `Completed`).
/// - Emits a new state whenever the filter changes.
class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterStateOnBloc> {
  TodoFilterBloc() : super(TodoFilterStateOnBloc.initial()) {
    /// 🔄 **Handles filter change events.**
    on<ChangeFilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.newFilter));
    });
  }
}
