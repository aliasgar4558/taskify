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
  String get unknownPage => 'Página desconocida';

  @override
  String get home => 'Inicio';

  @override
  String get emptyTasks =>
      'Aún no se han agregado tareas. Toca \'Agregar\' para crear una.';

  @override
  String get deleteTask => 'Eliminar tarea';

  @override
  String deleteTaskConfirmation(String label) {
    return '¿Estás seguro de que deseas eliminar \'$label\'?';
  }

  @override
  String get tasks => 'Tareas';

  @override
  String get add => 'Agregar';

  @override
  String get addNewItem => 'Agregar nuevo elemento';

  @override
  String get addTask => 'Agregar tarea';

  @override
  String get updateTask => 'Actualizar tarea';

  @override
  String get update => 'Actualizar';

  @override
  String get enterTaskName => 'Ingresa el nombre de la tarea';

  @override
  String get cancel => 'Cancelar';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String updatedOn(String value) {
    return 'Actualizado el: $value';
  }

  @override
  String get all => 'Todas';

  @override
  String get active => 'Activas';

  @override
  String get completed => 'Completadas';

  @override
  String get cannotUpdateCompletedTask =>
      'No puedes actualizar una tarea ya completada.';

  @override
  String get labelIsMandatory => 'La etiqueta es obligatoria';
}
