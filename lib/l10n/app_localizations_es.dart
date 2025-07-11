// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Taskify';

  @override
  String get unknownPage => 'Unknown page';

  @override
  String get home => 'Home';

  @override
  String get emptyTasks => 'No tasks added yet. Tap on \'Add\' to create one.';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String deleteTaskConfirmation(String label) {
    return 'Are you sure you want to delete \'$label\' ?';
  }

  @override
  String get tasks => 'Tasks';

  @override
  String get add => 'Add';

  @override
  String get addNewItem => 'Add new item';

  @override
  String get addTask => 'Add task';

  @override
  String get updateTask => 'Update task';

  @override
  String get update => 'Update';

  @override
  String get enterTaskName => 'Enter task name';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String updatedOn(String value) {
    return 'Updated on: $value';
  }

  @override
  String get all => 'All';

  @override
  String get active => 'Active';

  @override
  String get completed => 'Completed';

  @override
  String get cannotUpdateCompletedTask => 'You cannot update already completed task.';
}
