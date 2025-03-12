import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../models/todo_model.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

/// 📌 **[FilteredTodosBlocWithListenerStateShape] - Manages the filtered ToDos using Listener-Based State Shape.**
/// - **Filters ToDos based on the selected filter and search term.**
/// - **Listens for changes and updates the filtered list accordingly.**
/// - **State Shape:** Uses Bloc-based event handling.
class FilteredTodosBlocWithListenerStateShape extends Bloc<
    FilteredTodosEventWithListenerStateShape,
    FilteredTodosStateOnBlocWithListenerStateShape> {
  /// 🔽 **Initial ToDos List** (Unfiltered ToDos)
  final List<Todo> initialTodos;

  /// 🆕 **Constructor** - Initializes with the provided `initialTodos` list.
  FilteredTodosBlocWithListenerStateShape({
    required this.initialTodos,
  }) : super(FilteredTodosStateOnBlocWithListenerStateShape(
            filteredTodos: initialTodos)) {
    /// 🔄 **Handles filtering and updates the state.**
    on<CalculateFilteredTodosEventWithListenerStateShape>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }
}
