import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogUtil {
  static FutureOr<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? positiveActionText,
    String? negativeActionText,
    String? neutralActionText,
    bool wantNeutralButton = true,
  }) => showDialog<bool>(
    context: context,
    builder: (dialogCtx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => dialogCtx.pop(true),
          child: Text(positiveActionText ?? "Yes"),
        ),
        TextButton(
          onPressed: () => dialogCtx.pop(false),
          child: Text(negativeActionText ?? "No"),
        ),
        if (wantNeutralButton) ...[
          TextButton(
            onPressed: () => dialogCtx.pop(null),
            child: Text(neutralActionText ?? "Cancel"),
          ),
        ],
      ],
    ),
  );
}
