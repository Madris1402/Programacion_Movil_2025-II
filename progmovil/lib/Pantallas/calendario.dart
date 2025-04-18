import 'package:progmovil/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progmovil/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key, required this.title});

  final String title;

  @override
  State <Calendario> createState() => _CalendarioState();

}

class _CalendarioState extends State<Calendario>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  List <String> _nombresEventos = [];
  List <Map<String, dynamic>> _eventos = [];
  bool _datosCargados = false;

  Future<void> leerBaseDatos() async {
    _nombresEventos = [];
    _eventos = [];
    try {QuerySnapshot eventos = await db.collection("eventos").get();
      if (eventos.docs.isNotEmpty) {
        for (DocumentSnapshot evento in eventos.docs) {
          setState(() {
            _nombresEventos.add(evento.id);
            _eventos.add(evento.data() as Map<String, dynamic>);
          });
        }
        print("Nombre del Evento: $_nombresEventos");
        print("Evento: $_eventos");
      } else {
        print("No existe el documento");
      }
    }catch (e) {
    print("Error al leer la base de datos: $e");
    } finally {
      setState(() {
        _datosCargados = true;
      });
    }

  }


  @override
  void initState(){
    super.initState();
    leerBaseDatos();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title),
      ),
      body: _datosCargados ? SfCalendar(
        dataSource: MeetingDataSource(_getDataSource(_nombresEventos, _eventos)),
        todayHighlightColor: accent3,
        selectionDecoration: BoxDecoration(
          border: Border.all(color: accent),
        ),
        view: CalendarView.month,
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          agendaViewHeight: 200,
        ),
      ): const Center(
        child: SizedBox(
          width: 200,
          child: LinearProgressIndicator(
            color: accent,
            backgroundColor: Colors.white30,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context) => _guardarEvento());
        },
        tooltip: 'Agendar Evento',
        backgroundColor: accent,
        child: Icon(Icons.add),
      ),
    );

  }

  List<Meeting> _getDataSource(List <String> nombresEventos, List <Map<String, dynamic>> eventos ) {
    final List<Meeting> meetings = <Meeting>[];

    for(int i = 0; i < nombresEventos.length; i++) {
      DateTime fechaInicial = (eventos[i]['fechaInicial'] as Timestamp).toDate();
      DateTime fechaFinal = (eventos[i]['fechaFinal'] as Timestamp).toDate();
      meetings.add(
          Meeting(nombresEventos[i], fechaInicial,
          fechaFinal, Color(eventos[i]["color"] as int), eventos[i]['todoDia']));
    }
    return meetings;
  }
}



class _guardarEvento extends StatefulWidget { // Change to StatefulWidget
  const _guardarEvento({super.key}); // Constructor is now const

  @override
  State<_guardarEvento> createState() => _guardarEventoState();
}

class _guardarEventoState extends State<_guardarEvento> {  // Create a State class
  DateTime? _fechaSeleccionada;
  DateTime? _fechaInicial;
  DateTime? _fechaFinal;
  bool todoDia = false;

  TimeOfDay? _horaSeleccionada;
  TimeOfDay? _horaInicial;
  Color _colorSeleccionado = Colors.blueAccent;
  String _hexColor = "";

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _agendarEvento(String nombreEvento) {
    print("Nombre del Evento: $nombreEvento \n "
        "Fecha Inicial: $_fechaInicial \n "
        "Fecha Final: $_fechaFinal \n"
        "Color: $_hexColor \n"
        "Todo el día: $todoDia");

    _textEditingController.clear();
    Navigator.of(context).pop();
  }

  void _guardarFecha(BuildContext context, bool inicial) async {
    DateTime? fecha = await showDatePicker(
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Selecciona una fecha",
      context: context,
      initialDate: _fechaInicial ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    TimeOfDay? hora = await showTimePicker(
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Selecciona una hora",
      context: context,
      initialTime: _horaInicial ?? TimeOfDay.now(),
    );

    if (fecha != null && hora != null) { // Only update if both date and time are picked
      setState(() {
        _fechaSeleccionada = fecha;
        _horaSeleccionada = hora;
        if (inicial) {
          _fechaInicial = _fechaSeleccionada!.add(Duration(hours: _horaSeleccionada!.hour, minutes: _horaSeleccionada!.minute));
        } else {
          _fechaFinal = _fechaSeleccionada!.add(Duration(hours: _horaSeleccionada!.hour, minutes: _horaSeleccionada!.minute));
        }
      });
    }
  }

  void _seleccionarColor(BuildContext context) async {
    Color tempColor = _colorSeleccionado;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: MaterialPicker(
              pickerColor: tempColor,
              onColorChanged: (Color color) {
                tempColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                setState(() {
                  _colorSeleccionado = tempColor;
                  _hexColor = _colorSeleccionado.toHexString();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 600,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Evento",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _textEditingController,
                cursorColor: accent,
                decoration: InputDecoration(
                  hintText: 'Nombre del Evento',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: accent,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: _fechaInicial?.toString() ?? ""),
                decoration: InputDecoration(
                  hintText: 'Fecha Inicial',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: accent,
                      width: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  _guardarFecha(context, true);
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: _fechaFinal?.toString() ?? ""),
                decoration: InputDecoration(
                  hintText: 'Fecha Final',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: accent,
                      width: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  _guardarFecha(context, false);
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: _hexColor),
                decoration: InputDecoration(
                  hintText: 'Color',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: accent,
                      width: 2.0,
                    ),
                  ),
                ),
                onTap: () {
                  _seleccionarColor(context);
                },
              ),
            ),
            SizedBox(
              width: 200,
              child: CheckboxListTile(
                title: const Text("Todo el día"),
                value: todoDia,
                onChanged: (bool? value) {
                  setState(() {
                    todoDia = value!;
                  });
                }
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              shape: const StadiumBorder(),
              color: accent,
              onPressed: () {
                _agendarEvento(_textEditingController.text);
              },
              child: const Text("Guardar Evento"),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}