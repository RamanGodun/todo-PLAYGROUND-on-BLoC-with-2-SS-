part of 'todo_search_bloc.dart';

/// 📌 **[TodoSearchStateOnBloc] - Represents the search state in [TodoSearchBloc].**
/// - Stores the **current search term** entered by the user.
final class TodoSearchStateOnBloc extends Equatable {
  /// 📝 **Current search term** (used for filtering ToDos).
  final String searchTerm;

  const TodoSearchStateOnBloc({required this.searchTerm});

  /// 🔄 **Returns the initial state with an empty search term.**
  factory TodoSearchStateOnBloc.initial() {
    return const TodoSearchStateOnBloc(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TodoSearchState(searchTerm: $searchTerm)';

  /// 📝 **Creates a copy of the state with an updated search term.**
  TodoSearchStateOnBloc copyWith({
    String? searchTerm,
  }) {
    return TodoSearchStateOnBloc(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
