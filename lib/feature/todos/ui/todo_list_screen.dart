import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/config/extension/build_context_extension.dart';
import 'package:taskify/config/utils/dialog_util.dart';
import 'package:taskify/config/utils/shared_preference_util.dart';
import 'package:taskify/feature/todos/application/todo_list_bloc.dart';
import 'package:taskify/feature/todos/domain/models/todo.dart';
import 'package:taskify/feature/todos/ui/enum/todo_list_filter.dart';
import 'package:taskify/feature/todos/ui/widgets/show_add_todo_dialog.dart';

import 'widgets/todo_list_item_view.dart';

class TodoListScreen extends StatelessWidget {
  static const String kRoutePath = "/";
  static const String kRouteName = "todos";

  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<TodoListBloc>(
    create: (_) => TodoListBloc(
      sharedPreferenceUtil: SharedPreferenceUtil(),
    ),
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${context.l10n.appName} - ${context.l10n.home}"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FiltersView(),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 12.0),
              child: Text(context.l10n.tasks, style: context.textTheme.titleMedium),
            ),
            const SizedBox(height: 4.0),
            const _TodoListView(),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton.extended(
          onPressed: () => _onAddTodoBtnTap(context),
          tooltip: context.l10n.addNewItem,
          icon: const Icon(Icons.add),
          label: Text(context.l10n.add),
        ),
      ),
    ),
  );

  Future<void> _onAddTodoBtnTap(BuildContext context) async {
    final result = await showAddTodoDialogView(context: context);
    if (result != null) {
      /// user has submitted the data, we shall check & process.
      if (!context.mounted) {
        /// not valid context, we shall not proceed.
        return;
      }

      final TodoListBloc bloc = context.read();
      if (result is String) {
        /// new task to add.
        bloc.add(OnAddNewTodo(label: result));
      }
    }
  }
}

class _FiltersView extends StatelessWidget {
  const _FiltersView();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: kToolbarHeight,
    child: BlocSelector<TodoListBloc, TodoListState, TodoListFilter>(
      selector: (state) => state.selectedFilter,
      builder: (context, filter) => ListView(
        scrollDirection: Axis.horizontal,
        children: TodoListFilter.values.map((e) {
          final isSelected = (e == filter);
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 8.0,
            ),
            child: ActionChip(
              backgroundColor: isSelected ? context.colorScheme.primaryContainer : null,
              onPressed: () => context.read<TodoListBloc>().add(OnGetTodoList(filter: e)),
              avatar: isSelected ? Icon(Icons.check_rounded, color: context.colorScheme.onPrimaryContainer) : null,
              label: Text(
                e.getFriendlyText(context),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: isSelected ? context.colorScheme.onPrimaryContainer : null,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

class _TodoListView extends StatelessWidget {
  const _TodoListView();

  @override
  Widget build(BuildContext context) => Expanded(
    child: BlocSelector<TodoListBloc, TodoListState, List<Todo>>(
      selector: (state) => state.todos,
      builder: (context, todos) {
        if (todos.isEmpty) {
          return Center(child: Text(context.l10n.emptyTasks));
        }

        return ListView.separated(
          padding: const EdgeInsetsDirectional.only(bottom: 72.0),
          itemCount: todos.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoListItemView(
              item: todo,
              onTap: () => _onUpdateTodoBtnTap(context, todo),
              onDelete: () => _onDeletePressed(context, todo),
              onCheckChanged: (value) => context.read<TodoListBloc>().add(
                OnToggleTodoStatus(id: todo.id, completed: value),
              ),
            );
          },
        );
      },
    ),
  );

  Future<void> _onDeletePressed(BuildContext context, Todo todo) async {
    final wantToDeleteTodo = await DialogUtil.showConfirmationDialog(
      context: context,
      title: context.l10n.deleteTask,
      message: context.l10n.deleteTaskConfirmation(todo.label),
      wantNeutralButton: false,
    );

    if (wantToDeleteTodo == true && context.mounted) {
      context.read<TodoListBloc>().add(OnDeleteTodo(id: todo.id));
    }
  }

  Future<void> _onUpdateTodoBtnTap(BuildContext context, Todo todo) async {
    if (todo.completed) {
      context.showSnackBar(content: Text(context.l10n.cannotUpdateCompletedTask));
      return;
    }

    final result = await showAddTodoDialogView(context: context, toUpdate: todo);
    if (result != null) {
      /// user has submitted the data, we shall check & process.
      if (!context.mounted) {
        /// not valid context, we shall not proceed.
        return;
      }

      final TodoListBloc bloc = context.read();
      if (result is Todo) {
        /// existing task to update.
        bloc.add(OnUpdateTodoLabel(id: result.id, label: result.label));
      }
    }
  }
}
