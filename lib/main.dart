import 'package:flutter/material.dart';

import 'package:myapp/pages/SettingsScreen.dart';
import 'package:myapp/pages/AboutScreen.dart';
import 'package:myapp/pages/MQTTScreen.dart';
import 'package:myapp/pages/DashboardScreen.dart';

import 'package:myapp/fab_example.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      // home: DashboardPage(title: appTitle),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardPage(title: appTitle),
        '/settings': (context) => SettingsScreen(),
        '/mqtt': (context) => MQTTScreen(title: 'mqtt'),
        '/about': (context) => AboutScreen(),
        '/fab': (context) => const ExampleExpandableFab(),
      },
    );
  }
}
