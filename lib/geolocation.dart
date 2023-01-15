import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);
const List<String> list = <String>['Benzin', 'Diesel'];
const benzinFactor = 23.8;
const dieselFactor = 26.5;
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
  var _time = 0;
  var _speed = 0.0;
  var _run = false;
  var _relConsumption = 8.0;
  var _fuelType = "Benzin";
  var _co2Factor = benzinFactor;

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
  void initState() {
    super.initState();
    _loadParameters();
  }

  //Loading counter value on start
  Future<void> _loadParameters() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _distance = prefs.getDouble('distance') ?? 0;
      _relConsumption = prefs.getDouble('relConsumption') ?? 0;
      _fuelType = prefs.getString('fuelType') ?? "Benzin";
      _co2Factor = prefs.getDouble('co2Factor') ?? 0;
    });
  }

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
            Text("Geschwindigkeit (km/h): ${(_speed * 3.6).round()}"),
            Text("Distanz (m): ${_distance.round()}"),
            Text(
                "Gesamtverbrauch (l): ${(_distance * _relConsumption / 100000.0)}"),
            Text(
                "CO2-Emissionen (g): ${(_co2Factor * _distance * _relConsumption / 100000.0)}"),
            TextButton(
              child: Text("Start"),
              onPressed: () {
                _trackPosition();
              },
            ),
            TextButton(
              child: Text("Stop"),
              onPressed: () {
                _stop();
              },
            ),
            TextButton(
              child: Text("Reset"),
              onPressed: () {
                _reset();
              },
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20.0),
              child: const Text(
                  'Durchschnittlicher Verbrauch des genutzten PKW [l/100km]'),
            ),
            DropdownButton<String>(
              value: _fuelType,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  _fuelType = value!;
                  _co2Factor =
                      _fuelType == "Benzin" ? benzinFactor : dieselFactor;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                _relConsumption = double.parse(text);
              },
            ),
          ],
        ),
      ),
    );
  }

  _trackPosition() async {
    _run = true;
    final prefs = await SharedPreferences.getInstance();
    _distance = prefs.getDouble('distance') ?? 0;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied) {
      while (_run == true) {
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
                  newPosition.longitude);
              if (distance > 20) {
                var speed = distance /
                    ((DateTime.now().millisecondsSinceEpoch - _time) / 1000.0);
                if (speed * 3.6 > 25) {
                  _distance += distance;
                  _speed = speed;
                } else {
                  _speed = 0;
                }
                _time = DateTime.now().millisecondsSinceEpoch;
                _currentPosition = newPosition;
              }
            } else {
              _currentPosition = newPosition;
            }
          });
        }).catchError((e) {
          print(e);
        });
        await prefs.setDouble('distance', _distance);
        await prefs.setDouble('relConsumption', _relConsumption);
        await prefs.setString('fuelType', _fuelType);
        await prefs.setDouble('co2Factor', _co2Factor);
        await Future.delayed(Duration(seconds: 3));
      }
    }
  }

  _stop() async {
    setState(() {
      _run = false;
    });
  }

  _reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('distance');
    setState(() {
      _distance = 0;
    });
  }
}
