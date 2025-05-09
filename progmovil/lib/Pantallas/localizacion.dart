import 'package:progmovil/colors.dart';
import 'package:geolocator/geolocator.dart';


class Localizacion extends StatefulWidget {
  const Localizacion({super.key, required this.title});

  final String title;

  @override
  State <Localizacion> createState() => _LocalizacionState();


}

class _LocalizacionState extends State<Localizacion>{

  String _lat = "";
  String _long = "";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _obtenerCoordenadas() async{
    Position pos = await _determinePosition();
    setState(() {
      _lat= pos.latitude.toString();
      _long = pos.longitude.toString();
    });
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
              "Localización",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            MaterialButton(
              shape: StadiumBorder(side: BorderSide(width: 1)),
              onPressed: (){
                _obtenerCoordenadas();
              },
              color: accent,
              child: Text(
                "Obtener Localización"
              )
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Latitud: $_lat",
                        style: TextStyle(
                          fontSize: 20,
                        )
                    ),
                  ]
              ),
            ),
            SizedBox(
              width: 250,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        "Longitud: $_long",
                        style: TextStyle(
                          fontSize: 20,
                        )
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );

  }
}

