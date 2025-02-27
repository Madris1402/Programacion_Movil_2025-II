import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});

  final String title;

  @override
  State <Calculadora> createState() => _CalculadoraState();

}

class _CalculadoraState extends State<Calculadora>{


  double _res = 0;
  String _sres = "";
  double _percent = 0;
  int _operador = 0;
  double _val1 = 0;
  double _val2 = 0;
  bool _saved = false;

  // Colores Para los Botones
  Color _colorBotonSum = Colors.redAccent;
  Color _colorBotonRes = Colors.redAccent;
  Color _colorBotonMult = Colors.redAccent;
  Color _colorBotonDiv = Colors.redAccent;
  Color _colorBoton = Colors.redAccent;

  void _resetColors(){
    // Reiniciar Colores de los Botones
    _colorBotonSum = Colors.redAccent;
    _colorBotonRes = Colors.redAccent;
    _colorBotonMult = Colors.redAccent;
    _colorBotonDiv = Colors.redAccent;
  }

  void _cambiaNumero(String n){
    _sres+= n;
    setState(() {
    });
  }

  void _borrar(){
    setState(() {
      _sres = "";
      _reset();
      _resetColors();
    });
  }

  void _reset(){
    setState(() {
      _res = 0;
      _val1 = 0;
      _val2 = 0;
      _saved = false;
    });
  }

  void _porcentaje(){
    _res = double.parse(_sres);
    _percent = _res / 100;
    setState(() {
      _sres = _percent.toString();
    });
  }

  void _guardarVal1(){
    _saved = true;
    _val1 = double.parse(_sres);
    setState(() {
      _sres = "";
    });
  }

  void _guardarVal2(){
    _val2 = double.parse(_sres);
    setState(() {
      _sres = "";
    });
  }

  void _suma(){
    _operador = 1;
    setState(() {
      _colorBotonSum = Colors.deepOrangeAccent;
      //Resetear los demas botones a rojo
      _colorBotonRes = Colors.redAccent;
      _colorBotonMult = Colors.redAccent;
      _colorBotonDiv = Colors.redAccent;
    });
  }

  void _resta(){
    _operador = 2;
    setState(() {
      _colorBotonRes = Colors.deepOrangeAccent;
      //Resetear los demas botones a rojo
      _colorBotonSum = Colors.redAccent;
      _colorBotonMult = Colors.redAccent;
      _colorBotonDiv = Colors.redAccent;
    });
  }

  void _mult(){
    _operador = 3;
    setState(() {
      _colorBotonMult = Colors.deepOrangeAccent;
      //Resetear los demas botones a rojo
      _colorBotonSum = Colors.redAccent;
      _colorBotonRes = Colors.redAccent;
      _colorBotonDiv = Colors.redAccent;
    });
  }

  void _div(){
    _operador = 4;
    setState(() {
      _colorBotonDiv = Colors.deepOrangeAccent;
      //Resetear los demas botones a rojo
      _colorBotonSum = Colors.redAccent;
      _colorBotonMult = Colors.redAccent;
      _colorBotonRes = Colors.redAccent;
    });
  }

  void _igualA(){
    switch(_operador){
      case 1: // Suma
        _guardarVal2();
        _res = _val1 + _val2;
        setState(() {
          _sres = _res.toString();
          _reset();
        });
        break;

      case 2: // Resta
        _guardarVal2();
        _res = _val1 - _val2;
        setState(() {
          _sres = _res.toString();
          _reset();
        });
        break;

      case 3: // Multiplicacion
        _guardarVal2();
        _res = _val1 * _val2;
        setState(() {
          _sres = _res.toString();
          _reset();
        });
        break;

      case 4: // Division
        _guardarVal2();
        _res = _val1 / _val2;
        setState(() {
          _sres = _res.toString();
          _reset();
        });
        break;
    }

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
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              border: Border.all(color: Colors.redAccent, width: 3),
              borderRadius: BorderRadius.all(
                  Radius.circular(20)
              ),
            ),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              width: 350,
              child: Text(
                "$_sres",
              style: TextStyle(
                fontSize: 35,
              ),
                textAlign: TextAlign.end,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                // AC, 7, 4, 1, 0
                Column(
                  children: [
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _borrar();
                      },
                      color: _colorBoton,
                      child: Text("AC"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("7");
                      },
                      color: _colorBoton,
                      child: Text("7"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("4");
                      },
                      color: _colorBoton,
                      child: Text("4"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("1");
                      },
                      color: _colorBoton,
                      child: Text("1"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("0");
                      },
                      color: _colorBoton,
                      child: Text("0"),
                    ),
                  ],
                ),
                // (), 8, 5, 3, .
                Column(
                  children: [
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        if (_sres.contains(")") && _sres.contains("(")){
                          return;
                        } else if (_sres.contains("(")){
                          _cambiaNumero(")");
                        } else {
                          _cambiaNumero("(");
                        }
                       },
                      color: _colorBoton,
                      child: Text("()"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("8");
                      },
                      color: _colorBoton,
                      child: Text("8"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("5");
                      },
                      color: _colorBoton,
                      child: Text("5"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("2");
                      },
                      color: _colorBoton,
                      child: Text("2"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        if (_sres == ""){
                          _cambiaNumero("0");
                          _cambiaNumero(".");
                        } else if (_sres.contains(".")){
                          return;
                        } else {
                          _cambiaNumero(".");
                        }
                      },
                      color: _colorBoton,
                      child: Text("."),
                    ),
                  ],
                ),
                // %, 9, 6, 3, backspace
                Column(
                  children: [
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _porcentaje();
                      },
                      color: _colorBoton,
                      child: Text("%"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("9");
                      },
                      color: _colorBoton,
                      child: Text("9"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("6");
                      },
                      color: _colorBoton,
                      child: Text("6"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _cambiaNumero("3");
                      },
                      color: _colorBoton,
                      child: Text("3"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(16),
                      onPressed: (){
                        if (_sres.isEmpty){
                          return;
                        } else {
                          setState(() {
                            _sres = _sres.substring(0, _sres.length - 1);
                          });
                        }
                      },
                      color: _colorBoton,
                      child: Icon(Icons.backspace_outlined, size: 12,),
                    ),
                  ],
                ),
                // Operadores
                Column(
                  children: [
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        if(_saved){
                          _div();
                        } else{
                          _guardarVal1();
                          _div();
                        }
                      },
                      color: _colorBotonDiv,
                      child: Text("÷"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        if(_saved){
                          _mult();
                        } else{
                          _guardarVal1();
                          _mult();
                        }
                      },
                      color: _colorBotonMult,
                      child: Text("×"),
                    ),
                    MaterialButton(

                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        if(_saved){
                          _resta();
                        } else{
                          _guardarVal1();
                          _resta();
                        }
                      },
                      color: _colorBotonRes,
                      child: Text("-"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        if(_saved){
                          _suma();
                        } else{
                          _guardarVal1();
                          _suma();
                        }
                      },
                      color: _colorBotonSum,
                      child: Text("+"),
                    ),
                    MaterialButton(
                      shape: StadiumBorder(side: BorderSide(width: 1)),
                      padding: EdgeInsets.all(12),
                      onPressed: (){
                        _igualA();
                        setState(() {
                          _resetColors();
                        });
                      },
                      color: _colorBoton,
                      child: Text("="),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );

  }
}

