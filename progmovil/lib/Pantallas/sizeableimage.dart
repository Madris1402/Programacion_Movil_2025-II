import 'package:progmovil/colors.dart';
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
                        color: accent3
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
                    },
                    color: accent,
                    child: Icon(Icons.shuffle, size: 15,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: <Widget>[
                    MaterialButton(
                        shape: StadiumBorder(side: BorderSide(width: 1)),
                        onPressed: _increaseRandom,
                        color: accent,
                        child: Icon(Icons.plus_one, size: 15,)
                    ),
                    MaterialButton(
                        shape: StadiumBorder(side: BorderSide(width: 1)),
                        onPressed: _decreaseRandom,
                        color: accent,
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
                    backgroundColor: accent,
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
                          accent,
                        child: const Icon(Icons.unfold_less_rounded)
                    )
                  ]
            )
          ],
        )
    );
  }
}