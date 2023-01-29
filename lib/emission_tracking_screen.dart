import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);
const List<String> list = <String>['Benzin', 'Diesel'];
const benzinFactor = 23.8;
const dieselFactor = 26.5;
final scaffoldKey = GlobalKey<ScaffoldState>();

class EmissionTrackingScreen extends StatefulWidget {
  const EmissionTrackingScreen({super.key});

  Widget build(BuildContext context) {
    return const Scaffold(body: EmissionTrackingScreen());
  }

  @override
  State<StatefulWidget> createState() => _EmissionTrackingScreenState();
}

class _EmissionTrackingScreenState extends State<EmissionTrackingScreen> {
  // accumulated distance since last reset
  var _distance = 0.0;

  // time of most recent position record
  var _time = 0;
  var _speed = 0.0;
  var _monthlyEmissions = 0.0;
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
    _loadLocalParameters();
    _loadParametersFromDatabase();
  }

  _storeLocalParameters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('distance', _distance);
    await prefs.setDouble('relConsumption', _relConsumption);
    await prefs.setString('fuelType', _fuelType);
    await prefs.setDouble('co2Factor', _co2Factor);
  }

  _loadLocalParameters() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _distance = prefs.getDouble('distance') ?? 0;
      _relConsumption = prefs.getDouble('relConsumption') ?? 0;
      _fuelType = prefs.getString('fuelType') ?? "Benzin";
      _co2Factor = prefs.getDouble('co2Factor') ?? 0;
    });
  }

  _storeParametersInDatabase() async {
    final month = DateTime.now().month;
    Map<String, double> emissions = HashMap();
    setState(() {
      _monthlyEmissions += _getEmissionsSinceLastReset();
    });
    emissions.putIfAbsent(month.toString(), () => 0);
    emissions.update(month.toString(), (d) => _monthlyEmissions);
    _getDatabaseReference().update(emissions);
  }

  _loadParametersFromDatabase() async {
    DataSnapshot dataSnapshot = (await _getDatabaseReference().once()).snapshot;
    final month = DateTime.now().month;
    DataSnapshot child = dataSnapshot.child(month.toString());
    setState(() {
      _monthlyEmissions = double.parse(child.value.toString());
    });
  }

  DatabaseReference _getDatabaseReference() {
    User? user = FirebaseAuth.instance.currentUser;
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    return ref.child("MonthlyEmissions/${user?.uid}");
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('MMMM');
    final String monthName = formatter.format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
            SizedBox(
                width: 70.0,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _relConsumption.toString(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (text) {
                    _relConsumption = double.parse(text);
                  },
                )),
            const SizedBox(height: 50),
            Text(
                "Position: ${_currentPosition.latitude.toStringAsFixed(5)} °N, ${_currentPosition.longitude.toStringAsFixed(5)} °O"),
            Text("Geschwindigkeit (km/h): ${(_speed * 3.6).round()}"),
            Text("Distanz (m): ${_distance.round()}"),
            Text("Gesamtverbrauch (l): ${(_getConsumptionSinceLastReset())}"),
            Text("CO2-Emissionen (g): ${(_getEmissionsSinceLastReset())}"),
            TextButton(
              child: Text(_run ? "Stop recording" : "Start recoding"),
              onPressed: () {
                setState(() {
                  _run = !_run;
                });
                if (_run) {
                  _trackPosition();
                }
              },
            ),
            TextButton(
              child: const Text("Store and reset"),
              onPressed: () {
                _reset();
              },
            ),
            Text(
                "CO2-Emissionen in ${(monthName)} (kg): ${((_monthlyEmissions / 1000).toStringAsPrecision(2))}"),
          ],
        ),
      ),
    );
  }

  _trackPosition() async {
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
        _storeLocalParameters();
        await Future.delayed(const Duration(seconds: 3));
      }
    }
  }

  _reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('distance');
    setState(() {
      _distance = 0;
    });
    _storeParametersInDatabase();
  }

  double _getConsumptionSinceLastReset() {
    return _distance * _relConsumption / 100000.0;
  }

  double _getEmissionsSinceLastReset() {
    return _getConsumptionSinceLastReset() * _co2Factor;
  }
}
