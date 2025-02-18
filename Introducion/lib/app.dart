import 'package:flutter/material.dart';
import 'package:untitled/navegacion.dart';
import 'navegacion.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introdución',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const Navegador(title: "Navegador",),
    );
  }
}