import 'package:flutter/material.dart';
import 'package:taskify/config/constants/app_constants.dart';
import 'package:taskify/config/extension/build_context_extension.dart';
import 'package:taskify/feature/todos/domain/models/todo.dart';

class TodoListItemView extends StatelessWidget {
  final Todo item;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<bool> onCheckChanged;

  const TodoListItemView({
    required this.item,
    required this.onTap,
    required this.onDelete,
    required this.onCheckChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Checkbox(
            value: item.completed,
            onChanged: (value) {
              if (value != null) {
                onCheckChanged(value);
              }
            },
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: context.textTheme.titleMedium?.copyWith(
                    decoration: item.completed ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                Text(
                  context.l10n.updatedOn(
                    AppConstants.kAppDateFormat.format(
                      DateTime.fromMillisecondsSinceEpoch(item.updatedAt),
                    ),
                  ),
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_forever_outlined),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    ),
  );
}
