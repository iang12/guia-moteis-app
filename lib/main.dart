import 'package:flutter/material.dart';
import 'package:guia_moteis_app/modules/splash/ui/splash_page.dart';

import 'core/di/dependencies.dart';
import 'modules/motels/ui/motels_page.dart';

void main() async {
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guia de moteis',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/motels': (context) => const MotelsPage(),
      },
    );
  }
}
