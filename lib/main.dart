import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_projects/earthquake_logs/earthquake_data_provider.dart';
import 'package:practice_projects/earthquake_logs/earthquake_log.dart';
import 'package:practice_projects/earthquake_logs/settings.dart';
import 'package:practice_projects/navigate_screen.dart';
import 'package:practice_projects/word_hurdle_game/hurdle_provider.dart';
import 'package:practice_projects/word_hurdle_game/word_hurdle_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => HurdleProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => EarthQuakeDataProvider(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Projects',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
    );
  }

  final _router =
      GoRouter(initialLocation: '/', debugLogDiagnostics: true, routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const NavigateScreen(),
        routes: [
          GoRoute(
            name: WordHurdlePage.routeName,
            path: 'wordHurdle',
            builder: (context, state) => const WordHurdlePage(),
          ),
          GoRoute(
              name: EarthquakeLog.routeName,
              path: 'earthquake_log',
              builder: (context, state) => const EarthquakeLog(),
              routes: [
                GoRoute(
                  name: SettingsPage.routeName,
                  path: 'settings',
                  builder: (context, state) => const SettingsPage(),
                )
              ])
        ]),
  ]);
}
