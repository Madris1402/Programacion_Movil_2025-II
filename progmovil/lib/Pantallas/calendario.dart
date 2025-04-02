import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progmovil/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
          _nombresEventos.add(evento.id);
          _eventos.add(evento.data() as Map<String, dynamic>);
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
        onPressed: (){},
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