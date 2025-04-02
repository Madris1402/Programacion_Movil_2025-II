import 'package:flutter/material.dart';
import 'package:progmovil/Pantallas/calendario.dart';
import 'package:progmovil/Pantallas/ingreso.dart';
import 'package:progmovil/Pantallas/localizacion.dart';
import 'package:progmovil/Pantallas/sizeableimage.dart';
import 'package:progmovil/Pantallas/bienvenida.dart';
import 'package:progmovil/Pantallas/calculadora.dart';

import 'colors.dart';

class Navegador extends StatefulWidget {
  const Navegador({super.key, required this.title});

  final String title;

  @override
  State <Navegador> createState() => _NavegadorState();

}

  class _NavegadorState extends State<Navegador>{

  int _p = 0;
  final List<Widget> _pantallas = [];

  Widget _cuerpo = const Text(
      "Soy el cuerpo",
          style: TextStyle(
            fontSize: 40,
          ),

    );


    @override
    void initState(){
      super.initState();
      _pantallas.add(Ingreso(title: "Programación Móvil", bienvenida: _cambiaPantalla));
      _pantallas.add(const Bienvenida(title: "Bienvenida"));
      _pantallas.add(const MyHomePage(title: "Cambiar Imagen de Tamaño"));
      _pantallas.add(const Calculadora(title: "Calculadora"));
      _pantallas.add(const Localizacion(title: "Localización"));
      _pantallas.add(const Calendario(title: "Calendario"));
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
          currentIndex: _p,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: accent,
          unselectedItemColor: Colors.white38,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Principal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Bienvenida",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_size_select_large),
              label: 'Cambiar Imagen de Tamaño',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: "Calculadora",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: "Localización",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Calendario",
            )
          ],
        ),
      );
    }
  }

