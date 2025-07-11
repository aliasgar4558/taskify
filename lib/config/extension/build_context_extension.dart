import 'package:flutter/material.dart';
import 'package:taskify/l10n/app_localizations.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Shows a Snack bar with the specified content.
  ///
  /// The [showSnackBar] method is used to display a Snack bar with the provided [content].
  /// It first hides any currently displayed Snack bar and then shows a new one with the
  /// specified content.
  void showSnackBar({
    required Widget content,
  }) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: content));
  }
}
