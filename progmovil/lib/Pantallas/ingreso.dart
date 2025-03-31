import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ingreso extends StatefulWidget {
  const Ingreso({super.key, required this.title, required this.bienvenida});

  final String title;
  final Function bienvenida;

  @override
  State <Ingreso> createState() => _IngresoState();

}

class _IngresoState extends State<Ingreso>{

  final TextEditingController _controller = TextEditingController();

  Future<SharedPreferences> _obtenerPreferencias() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  void _escribirDatos() async{
    final SharedPreferences pref = await _obtenerPreferencias();
    pref.setString("Nombre", _controller.text);
    _controller.text = "";
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
              "Ingresar",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Ingresa tu Nombre',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: (){
                _escribirDatos();
                widget.bienvenida(1);
              },
              child: Text("Enviar"),
            )
          ],
        ),
      ),
    );

  }
}

