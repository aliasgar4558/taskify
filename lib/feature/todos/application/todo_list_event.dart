part of 'todo_list_bloc.dart';

sealed class TodoListEvent {
  const TodoListEvent();
}

class OnGetTodoList extends TodoListEvent {
  final TodoListFilter filter;

  const OnGetTodoList({required this.filter});
}

class OnAddNewTodo extends TodoListEvent {
  final String label;

  const OnAddNewTodo({required this.label});
}

class OnUpdateTodoLabel extends TodoListEvent {
  final String id;
  final String label;

  const OnUpdateTodoLabel({
    required this.id,
    required this.label,
  });
}

class OnDeleteTodo extends TodoListEvent {
  final String id;

  const OnDeleteTodo({required this.id});
}

class OnToggleTodoStatus extends TodoListEvent {
  final String id;
  final bool completed;

  const OnToggleTodoStatus({
    required this.id,
    required this.completed,
  });
}
