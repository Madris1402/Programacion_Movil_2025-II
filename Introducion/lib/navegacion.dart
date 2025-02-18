import 'package:flutter/material.dart';
import 'package:untitled/Pantallas/principal.dart';
import 'package:untitled/Pantallas/segunda.dart';
import 'main.dart';

class Navegador extends StatefulWidget {
  const Navegador({super.key, required this.title});

  final String title;

  @override
  State <Navegador> createState() => _NavegadorState();

}

  class _NavegadorState extends State<Navegador>{

  int _p = 0;
  List<Widget> _pantallas = [];

  Widget _cuerpo = const Text(
      "Soy el cuerpo",
          style: TextStyle(
            fontSize: 40,
          ),

    );


    @override
    void initState(){
      super.initState();
      _pantallas.add(const MyHomePage(title: "Cambiar Imagen de Tamaño"));
      _pantallas.add(const Segunda(title: "Otra pantalla"));
      _cuerpo = _pantallas[_p];

    }

    void _cambiaPantalla(int v){
      _p = v;
      setState(() {
        _cuerpo = _pantallas[_p];
      });
    }



    @override
    Widget build(BuildContext context){
      return Scaffold(
        body: _cuerpo,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value){
            _cambiaPantalla(value);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              label: 'Atrás',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward),
              label: "Adelante",
            )
          ],
        ),
      );
    }
  }

