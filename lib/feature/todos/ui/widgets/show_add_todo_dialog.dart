import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/config/extension/build_context_extension.dart';
import 'package:taskify/config/extension/string_extension.dart';
import 'package:taskify/feature/todos/domain/models/todo.dart';

Future<dynamic> showAddTodoDialogView({
  required BuildContext context,
  Todo? toUpdate,
}) => showDialog<dynamic>(
  context: context,
  builder: (dialogCtx) => _DialogView(toUpdate),
);

class _DialogView extends StatefulWidget {
  final Todo? toUpdate;

  const _DialogView(this.toUpdate);

  @override
  State<_DialogView> createState() => _DialogViewState();
}

class _DialogViewState extends State<_DialogView> {
  String? errorMsg;
  late final TextEditingController _labelController = TextEditingController(
    text: widget.toUpdate?.label,
  );

  @override
  Widget build(BuildContext context) => AlertDialog.adaptive(
    title: Text(widget.toUpdate == null ? context.l10n.addTask : context.l10n.updateTask),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    content: TextFormField(
      keyboardType: TextInputType.text,
      controller: _labelController,
      decoration: InputDecoration(
        errorText: errorMsg,
        hintText: context.l10n.enterTaskName,
        border: const OutlineInputBorder(),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => context.pop(),
        child: Text(
          context.l10n.cancel,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.error,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          final value = _labelController.text.trim();
          if (value.isNullOrEmpty) {
            /// Using setState just for this dialog because it won't be any heavy UI rendering.
            setState(() {
              errorMsg = context.l10n.labelIsMandatory;
            });
            return;
          }

          if (widget.toUpdate == null) {
            context.pop(_labelController.text.trim());
          } else {
            context.pop(
              widget.toUpdate?.copyWith(
                label: _labelController.text.trim(),
              ),
            );
          }
        },
        child: Text(widget.toUpdate == null ? context.l10n.add : context.l10n.update),
      ),
    ],
  );
}
