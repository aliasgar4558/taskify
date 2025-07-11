part of 'todo_list_bloc.dart';

enum TodoListStatus {
  initial,
  inProgress,
  success,
  failure,
}

class TodoListState extends Equatable {
  final TodoListStatus status;
  final TodoListFilter selectedFilter;
  final List<Todo> todos;

  const TodoListState({
    required this.status,
    this.selectedFilter = TodoListFilter.all,
    this.todos = const [],
  });

  factory TodoListState.initial() => const TodoListState(
    status: TodoListStatus.initial,
    selectedFilter: TodoListFilter.all,
  );

  TodoListState copyWith({
    TodoListStatus? status,
    TodoListFilter? selectedFilter,
    List<Todo>? todos,
  }) => TodoListState(
    status: status ?? this.status,
    selectedFilter: selectedFilter ?? this.selectedFilter,
    todos: todos ?? this.todos,
  );

  @override
  List<Object?> get props => [
    status,
    selectedFilter,
    ...todos,
  ];
}
