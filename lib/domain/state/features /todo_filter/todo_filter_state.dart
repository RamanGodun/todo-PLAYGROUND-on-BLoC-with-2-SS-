part of 'todo_filter_bloc.dart';

/// 🎛 **[TodoFilterStateOnBloc] - Represents the current filter state.**
/// - Used in **[TodoFilterBloc]** to manage the active filter.
/// - Determines which ToDo items should be displayed based on their completion status.
final class TodoFilterStateOnBloc extends Equatable {
  /// 🎯 **Current filter mode applied (All, Active, or Completed).**
  final Filter filter;

  const TodoFilterStateOnBloc({
    required this.filter,
  });

  /// 🔄 **Returns the initial state with the default filter (`Filter.all`).**
  factory TodoFilterStateOnBloc.initial() {
    return const TodoFilterStateOnBloc(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'TodoFilterState(filter: $filter)';

  /// 📝 **Creates a copy of the state with updated properties.**
  TodoFilterStateOnBloc copyWith({
    Filter? filter,
  }) {
    return TodoFilterStateOnBloc(
      filter: filter ?? this.filter,
    );
  }
}
