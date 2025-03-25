import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({super.key, required this.title});

  final String title;

  @override
  State <Bienvenida> createState() => _BienvenidaState();

}

class _BienvenidaState extends State<Bienvenida>{

  String _Nombre = "";

  void _leerDatos() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? aux = pref.getString("Nombre");
    if(aux != null){
     setState(() {
       _Nombre = aux;
     });
    }
  }

  @override
  initState(){
    super.initState();
    _leerDatos();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bienvenid@",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            Text(
              _Nombre,
              style: TextStyle(
                fontSize: 40,
              ),
            )
          ],
        ),
      ),
    );

  }
}

