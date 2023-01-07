import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' show cos, sqrt, asin;
import 'dart:async';

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
  var _distance = 0.0;
  var _starttime = 0;
  var _speed = 0.0;
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
            Text("Distanz (m): ${_distance.round()}"),
            Text("Geschwindigkeit (m/s): ${_speed.round()}"),
            Text("Geschwindigkeit (km/h): ${(_speed * 3.6).round()}"),
            TextButton(
              child: Text("Start"),
              onPressed: () {
                _trackPosition();
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

  _trackPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      while (true) {
        Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best,
                forceAndroidLocationManager: true)
            .then((Position newPosition) {
          setState(() {
            if (_currentPosition.latitude != 0 ||
                _currentPosition.longitude != 0) {
              var distance = Geolocator.distanceBetween(
                  _currentPosition.latitude,
                  _currentPosition.longitude,
                  newPosition.latitude,
                  newPosition.longitude
              );
              if (distance > 20) {
                _distance += distance;
                _speed = _distance /
                    ((DateTime.now().millisecondsSinceEpoch - _starttime) /
                        1000.0);
                _currentPosition = newPosition;
              }
            } else {
              _starttime = DateTime.now().millisecondsSinceEpoch;
              _currentPosition = newPosition;
            }
          });
        }).catchError((e) {
          print(e);
        });
        await Future.delayed(Duration(seconds: 3));
      }
    }
  }

}
