import 'package:flutter/material.dart';
import 'package:untitled/Pantallas/principal.dart';
import 'package:untitled/Pantallas/segunda.dart';
import 'package:untitled/Pantallas/calculadora.dart';
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
      _pantallas.add(const Calculadora(title: "Calculadora"));
      _cuerpo = _pantallas[_p];

    }

    void _cambiaPantalla(int v){
      if (v == 0) {
        if(_p <= 0){
          _p = 0;
        } else{
          _p--;
          print(_p);
        }
      } else if (v == 1) {
        if(_p >= _pantallas.length -1){
          _p = _pantallas.length -1;
        } else{
          _p ++;
          print(_p);
        }
      }
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

