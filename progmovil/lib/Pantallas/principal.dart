import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;
  String _texto = "";
  bool _isShuffle = false;

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

  void _sustituirCaracter(caracterViejo, cadenaNueva){
    setState(() {
      _texto = _texto.replaceAll(caracterViejo, cadenaNueva);
    });
  }

  void _increaseRandom(){
    Random r = Random();
    int n = 97 + r.nextInt(25);
    setState(() {
      _texto += String.fromCharCode(n);
    });
  }

  void _decreaseRandom(){
    setState(() {
      _texto = _texto.substring(0, _texto.length -1);
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
        drawer: Drawer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: <Widget>[
                Text(
                  "Cadena Aleatoria",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  _texto,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.orangeAccent
                  ),
                ),
                MaterialButton(
                    shape: StadiumBorder(side: BorderSide(width: 1)),
                    onPressed: (){
                      _isShuffle = !_isShuffle;
                      _isShuffle ? _sustituirCaracter("a", "1"):_sustituirCaracter("1", "a");
                      _isShuffle ? _sustituirCaracter("b", "2"):_sustituirCaracter("2", "b");
                      _isShuffle ? _sustituirCaracter("c", "3"):_sustituirCaracter("3", "c");
                      _isShuffle ? _sustituirCaracter("d", "4"):_sustituirCaracter("4", "d");
                      _isShuffle ? _sustituirCaracter("e", "5"):_sustituirCaracter("5", "e");
                    },
                    color: Colors.redAccent,
                    child: Icon(Icons.shuffle, size: 15,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: <Widget>[
                    MaterialButton(
                        shape: StadiumBorder(side: BorderSide(width: 1)),
                        onPressed: _increaseRandom,
                        color: Colors.redAccent,
                        child: Icon(Icons.plus_one, size: 15,)
                    ),
                    MaterialButton(
                        shape: StadiumBorder(side: BorderSide(width: 1)),
                        onPressed: _decreaseRandom,
                        color: Colors.redAccent,
                        child: Icon(Icons.exposure_minus_1, size: 15,)
                    )
                  ],
                )
              ],
            ),
          ),
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
              Image.network(width: _counter, "https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187.jpg?w=1436&h=958"),
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