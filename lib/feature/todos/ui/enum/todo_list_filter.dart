import 'package:flutter/material.dart';
import 'package:taskify/config/extension/build_context_extension.dart';

enum TodoListFilter {
  all,
  active,
  completed;

  String getFriendlyText(BuildContext context) => switch (this) {
    TodoListFilter.all => context.l10n.all,
    TodoListFilter.active => context.l10n.active,
    TodoListFilter.completed => context.l10n.completed,
  };
}
