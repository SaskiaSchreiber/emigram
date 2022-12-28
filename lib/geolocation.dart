import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);
final scaffoldKey = GlobalKey<ScaffoldState>();

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Geolocation());
  }

  @override
  State<StatefulWidget> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  Position _currentPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  @override
  Widget build(BuildContext context) {
    //final user= FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
            TextButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(height: 40),
          Container(
              width: 320.0,
              height: 40.0,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[accent, primary])),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                },
                child: const Text('Plaid aktivieren'),
              )),
          const SizedBox(height: 40),
          Container(
              width: 320.0,
              height: 40.0,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[accent, primary])),
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                },
                child: const Text('Googlemaps aktivieren'),
              )),
        ]),
      ),
    );
  }

  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
        });
      }).catchError((e) {
        print(e);
      });
    }
  }
}
