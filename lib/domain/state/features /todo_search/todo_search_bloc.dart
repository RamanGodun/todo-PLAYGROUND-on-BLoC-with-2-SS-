import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

/// 🔍 **[TodoSearchBloc] - Manages ToDo search functionality.**
/// - **Debounced search**: Prevents unnecessary state updates while the user types.
/// - **Handles search input changes** and updates the **[TodoSearchStateOnBloc]**.
class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchStateOnBloc> {
  /// 🆕 **Initializes with an empty search term.**
  TodoSearchBloc() : super(TodoSearchStateOnBloc.initial()) {
    /// 🔄 **Handles search term changes with debounce.**
    on<SetSearchTermEvent>(
      (event, emit) {
        emit(state.copyWith(searchTerm: event.newSearchTerm));
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  /// ⏳ **Debounce transformer** - Delays event processing to optimize performance.
  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(
      Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
