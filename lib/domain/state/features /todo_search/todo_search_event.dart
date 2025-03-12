part of 'todo_search_bloc.dart';

/// 🎭 **[TodoSearchEvent] - Defines search-related events for [TodoSearchBloc].**
sealed class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

/// 🔎 **[SetSearchTermEvent] - Updates the search term.**
/// - Used to filter ToDos based on user input.
final class SetSearchTermEvent extends TodoSearchEvent {
  final String newSearchTerm;

  const SetSearchTermEvent({
    required this.newSearchTerm,
  });

  @override
  String toString() => 'SetSearchTermEvent(newSearchTerm: $newSearchTerm)';

  @override
  List<Object> get props => [newSearchTerm];
}
