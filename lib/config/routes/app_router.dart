import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/config/extension/build_context_extension.dart';
import 'package:taskify/error_screen.dart';
import 'package:taskify/feature/todos/ui/todo_list_screen.dart';

/// Global navigator state key that shall be used very carefully if used explicitly.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// The `AppRouter` class is responsible for managing the routing functionality of the application.
/// It utilizes the `GoRouter` package to handle navigation between different screens or routes.
///
/// Usage :
/// ```dart
/// MaterialApp.router(
///    routerConfig: AppRouter.instance.router,
/// )
/// ```
class AppRouter {
  // Private constructor
  AppRouter._() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: TodoListScreen.kRoutePath,
          name: TodoListScreen.kRouteName,
          builder: (context, state) => const TodoListScreen(),
        ),
      ],

      // The errorBuilder is invoked when a route is not found, and it displays the error message.
      errorBuilder: (context, state) => ErrorScreen(
        message: context.l10n.unknownPage,
      ),
    );
  }

  // Singleton instance
  static final _instance = AppRouter._();

  /// Returns the singleton instance of [AppRouter].
  static AppRouter get instance => _instance;

  /// GO Router instance with all the routes specified at the time of instance creation.
  late GoRouter router;
}
