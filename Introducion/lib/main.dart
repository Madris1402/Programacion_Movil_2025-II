import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const MyHomePage(title: 'Introducción a Programación Móvil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 15;
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter = _counter - 15;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            const Text(
              'Presiona el botón para cambiar el tamaño de la imagen:',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            Text(
              'Ancho: $_counter px',
              style: TextStyle(
                fontSize: 12
              ),
            ),
            Image.network(width: _counter, "https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187.jpg?w=1436&h=958")
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            right: 70,
            bottom: 10,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.unfold_more)
            )
          ),
          Positioned(
            bottom: 10,
            right: 0,
              child: FloatingActionButton(
                  onPressed: _decreaseCounter,
                  tooltip: 'Decrease',
                  backgroundColor: Colors.redAccent,
                  child: const Icon(Icons.unfold_less_rounded)
              )
          )
        ],
      )
    );
  }
}