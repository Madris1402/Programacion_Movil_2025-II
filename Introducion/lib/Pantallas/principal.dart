import 'package:flutter/material.dart';

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
      if(_counter > 420){
        _counter = 420;
      }
    });
  }

  void _decreaseCounter() {
    setState(() {
      _counter = _counter - 15;
      if(_counter < 0){
        _counter = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black,
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