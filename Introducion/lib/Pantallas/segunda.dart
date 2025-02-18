import 'package:flutter/material.dart';

class Segunda extends StatefulWidget {
  const Segunda({super.key, required this.title});

  final String title;

  @override
  State <Segunda> createState() => _SegundaState();

}

class _SegundaState extends State<Segunda>{
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
              "Otra Pantalla",
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

