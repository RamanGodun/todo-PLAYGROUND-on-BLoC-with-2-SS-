part of 'todo_filter_bloc.dart';

/// 📌 **[TodoFilterEvent] - Defines events for managing ToDo filtering.**
/// - Used in **[TodoFilterBloc]** to modify the active filter mode.
sealed class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

/// 🔄 **[ChangeFilterEvent] - Updates the ToDo filter.**
/// - Triggers a state change in **[TodoFilterBloc]**.
/// - Can switch between **All, Active, or Completed** tasks.
final class ChangeFilterEvent extends TodoFilterEvent {
  /// 🎯 **New filter to be applied.**
  final Filter newFilter;

  const ChangeFilterEvent({required this.newFilter});

  @override
  String toString() => 'ChangeFilterEvent(newFilter: $newFilter)';

  @override
  List<Object> get props => [newFilter];
}
