import 'package:flutter/material.dart';
import 'package:taskify/config/routes/app_router.dart';
import 'package:taskify/l10n/app_localizations.dart';

class TaskifyApp extends StatelessWidget {
  const TaskifyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Taskify',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    routerConfig: AppRouter.instance.router,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  );
}
