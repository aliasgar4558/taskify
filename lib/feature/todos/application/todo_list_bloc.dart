import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/config/utils/shared_preference_util.dart';
import 'package:taskify/feature/todos/domain/models/todo.dart';
import 'package:taskify/feature/todos/domain/models/todo_list_response.dart';
import 'package:taskify/feature/todos/ui/enum/todo_list_filter.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

/// A BLoC (Business Logic Component) that manages the task list functionality.
///
/// It handles actions like fetching, adding, updating, deleting,
/// and toggling task items. It uses [SharedPreferenceUtil] as the persistent store.
class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  final SharedPreferenceUtil _sharedPreferenceUtil;

  TodoListBloc({
    required SharedPreferenceUtil sharedPreferenceUtil,
  }) : _sharedPreferenceUtil = sharedPreferenceUtil,
       super(TodoListState.initial()) {
    on<OnGetTodoList>(_onGetTodoList);
    on<OnAddNewTodo>(_onAddNewTodo);
    on<OnUpdateTodoLabel>(_onUpdateTodoLabel);
    on<OnDeleteTodo>(_onDeleteTodo);
    on<OnToggleTodoStatus>(_onToggleTodoStatus);

    add(const OnGetTodoList(filter: TodoListFilter.all));
  }

  /// Fetches the saved todos from shared preferences and decodes them into a list.
  ///
  /// Returns an empty list if no valid data is found.
  Future<List<Todo>> _getAllTodosFromSharedPref() async {
    final savedTodosStr = await _sharedPreferenceUtil.getTodos;
    return savedTodosStr != null ? TodoListResponse.fromJson(jsonDecode(savedTodosStr)).todos : [];
  }

  /// Handles the [OnGetTodoList] event and emits filtered todos.
  Future<void> _onGetTodoList(
    OnGetTodoList event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(selectedFilter: event.filter, status: TodoListStatus.inProgress));
    final allSavedTodos = await _getAllTodosFromSharedPref();
    final List<Todo> effectiveTodos = _filterTodos(allSavedTodos, event.filter);
    emit(state.copyWith(todos: effectiveTodos, status: TodoListStatus.success));
  }

  /// Filters the provided task list based on the selected [TodoListFilter].
  List<Todo> _filterTodos(List<Todo> todos, TodoListFilter filter) => switch (filter) {
    TodoListFilter.all => todos,
    TodoListFilter.active => todos.where((e) => !e.completed).toList(),
    TodoListFilter.completed => todos.where((e) => e.completed).toList(),
  };

  /// Handles the [OnAddNewTodo] event by creating and storing a new task item.
  Future<void> _onAddNewTodo(
    OnAddNewTodo event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: TodoListStatus.inProgress));
    final dateNowSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    final Todo todoToAdd = Todo(
      id: dateNowSinceEpoch.toString(),
      label: event.label,
      createdAt: dateNowSinceEpoch,
      updatedAt: dateNowSinceEpoch,
    );

    final allSavedTodos = await _getAllTodosFromSharedPref();
    allSavedTodos.add(todoToAdd);
    await _updateTodos(allSavedTodos, emit);
  }

  /// Handles the [OnUpdateTodoLabel] event by updating the label of the specified task.
  Future<void> _onUpdateTodoLabel(
    OnUpdateTodoLabel event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: TodoListStatus.inProgress));
    final allSavedTodos = await _getAllTodosFromSharedPref();

    final todoAt = allSavedTodos.indexWhere(
      (element) => element.id == event.id,
    );
    if (!todoAt.isNegative) {
      // Valid id, we can proceed.
      final dateNowSinceEpoch = DateTime.now().millisecondsSinceEpoch;
      final effectiveTodo = allSavedTodos[todoAt].copyWith(
        label: event.label,
        updatedAt: dateNowSinceEpoch,
      );
      allSavedTodos[todoAt] = effectiveTodo;
      await _updateTodos(allSavedTodos, emit);
    } else {
      emit(state.copyWith(status: TodoListStatus.failure));
    }
  }

  /// Handles the [OnDeleteTodo] event by removing the specified task from the list.
  Future<void> _onDeleteTodo(
    OnDeleteTodo event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: TodoListStatus.inProgress));
    final allSavedTodos = await _getAllTodosFromSharedPref();

    final todoAt = allSavedTodos.indexWhere(
      (element) => element.id == event.id,
    );
    if (!todoAt.isNegative) {
      // Valid id, we can proceed.
      allSavedTodos.removeAt(todoAt);
      await _updateTodos(allSavedTodos, emit);
    } else {
      emit(state.copyWith(status: TodoListStatus.failure));
    }
  }

  /// Handles the [OnToggleTodoStatus] event to toggle completion status of the specified task.
  Future<void> _onToggleTodoStatus(
    OnToggleTodoStatus event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: TodoListStatus.inProgress));
    final allSavedTodos = await _getAllTodosFromSharedPref();

    final todoAt = allSavedTodos.indexWhere(
      (element) => element.id == event.id,
    );
    if (!todoAt.isNegative) {
      // Valid id, we can proceed.
      final dateNowSinceEpoch = DateTime.now().millisecondsSinceEpoch;
      final effectiveTodo = allSavedTodos[todoAt].copyWith(
        completed: event.completed,
        updatedAt: dateNowSinceEpoch,
      );
      allSavedTodos[todoAt] = effectiveTodo;
      await _updateTodos(allSavedTodos, emit);
    } else {
      emit(state.copyWith(status: TodoListStatus.failure));
    }
  }

  /// Encodes the updated tasks list and saves it to shared preferences,
  /// then re-triggers the [OnGetTodoList] event to refresh the UI.
  Future<void> _updateTodos(List<Todo> todos, Emitter<TodoListState> emit) async {
    final encodedResponse = jsonEncode(TodoListResponse(todos: todos).toJson());
    await _sharedPreferenceUtil.updateTodos(encodedResponse);
    add(OnGetTodoList(filter: state.selectedFilter));
  }
}
