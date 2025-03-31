import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Incrementar el tamaño de la imagen
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

  // Conexión a Firebase

  final FirebaseFirestore db = FirebaseFirestore.instance;

  void _escribirBaseDatos() async {
    try {
      await db.collection("numeros").doc("Contador").set({"contador": _counter});
      print("Se ha escrito $_counter en la base de datos");
    } catch (e) {
      print("Error al escribir la base de datos: $e");
    }
  }

  void _leerBaseDatos() async {
    try {DocumentSnapshot doc = await db.collection("numeros").doc("Contador").get();

        if (doc.exists){
          final dynamic valor = doc.get("contador");
          setState(() {
            _counter = valor.toDouble();
          });
        } else {
          print("No existe el documento");
        }
    } catch (e) {
      print("Error al leer la base de datos: $e");
    }
  }

  // Sustituir caracteres
  void _sustituirCaracter(caracterViejo, cadenaNueva){
    setState(() {
      _texto = _texto.replaceAll(caracterViejo, cadenaNueva);
    });
  }

  // Generar cadena aleatoria
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
  void initState(){
    super.initState();
    _leerBaseDatos();
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
                SizedBox(
                  width: 250,
                  child: Text(
                    _texto,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.orangeAccent
                    ),
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
                      _isShuffle ? _sustituirCaracter("f", "6"):_sustituirCaracter("6", "f");
                      _isShuffle ? _sustituirCaracter("g", "7"):_sustituirCaracter("7", "g");
                      _isShuffle ? _sustituirCaracter("h", "8"):_sustituirCaracter("8", "h");
                      _isShuffle ? _sustituirCaracter("i", "9"):_sustituirCaracter("9", "i");
                      _isShuffle ? _sustituirCaracter("j", "0"):_sustituirCaracter("0", "j");
                      _isShuffle ? _sustituirCaracter("k", "!"):_sustituirCaracter("!", "k");
                      _isShuffle ? _sustituirCaracter("l", "@"):_sustituirCaracter("@", "l");
                      _isShuffle ? _sustituirCaracter("m", "#"):_sustituirCaracter("#", "m");
                      _isShuffle ? _sustituirCaracter("n", "\$"):_sustituirCaracter("\$", "n");
                      _isShuffle ? _sustituirCaracter("o", "%"):_sustituirCaracter("%", "o");
                      _isShuffle ? _sustituirCaracter("p", "^"):_sustituirCaracter("^", "p");
                      _isShuffle ? _sustituirCaracter("q", "&"):_sustituirCaracter("&", "q");
                      _isShuffle ? _sustituirCaracter("r", "*"):_sustituirCaracter("*", "r");
                      _isShuffle ? _sustituirCaracter("s", "("):_sustituirCaracter("(", "s");
                      _isShuffle ? _sustituirCaracter("t", ")"):_sustituirCaracter(")", "t");
                      _isShuffle ? _sustituirCaracter("u", "-"):_sustituirCaracter("-", "u");
                      _isShuffle ? _sustituirCaracter("v", "_"):_sustituirCaracter("_", "v");
                      _isShuffle ? _sustituirCaracter("w", "+"):_sustituirCaracter("+", "w");
                      _isShuffle ? _sustituirCaracter("x", "="):_sustituirCaracter("=", "x");
                      _isShuffle ? _sustituirCaracter("y", "["):_sustituirCaracter("[", "y");
                      _isShuffle ? _sustituirCaracter("z", "]"):_sustituirCaracter("]", "z");
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
              SizedBox(
                width: 350,
                child: const Text(
                  'Presiona el botón para cambiar el tamaño de la imagen:',
                  style: TextStyle(
                      fontSize: 15
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                    onPressed: (){
                      _incrementCounter();
                      _escribirBaseDatos();
                    },
                    tooltip: 'Increment',
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.unfold_more)
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                        onPressed: (){
                          _decreaseCounter();
                          _escribirBaseDatos();
                        },
                          tooltip: 'Decrease',
                          backgroundColor:
                          Colors.redAccent,
                        child: const Icon(Icons.unfold_less_rounded)
                    )
                  ]
            )
          ],
        )
    );
  }
}