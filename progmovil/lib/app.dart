import 'package:flutter/material.dart';
import 'package:progmovil/colors.dart';
import 'package:progmovil/navegacion.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introdución',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const Navegador(title: "Navegador",),
    );
  }
}