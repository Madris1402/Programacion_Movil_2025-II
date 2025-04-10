import 'package:progmovil/colors.dart';
import '../widgets/tarjetas.dart';


class Personal extends StatefulWidget{
  const Personal({super.key, required this.title,});

  final String title;

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent ,
        title: Text(widget.title),
      ),
        body: Center(
          child: Tarjetas(nombre: ["Joaquin"],
            descripcion: ["Hola soy joaquin"],
            rutas: ["assets/images/cocodrilo.jpg"],
            width: 500,
            height: 100,
            color: Colors.pinkAccent,
          )
        )
    );
  }
}