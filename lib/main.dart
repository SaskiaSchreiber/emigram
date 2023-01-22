import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:emigram/register_screen.dart';
import 'package:emigram/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:emigram/geolocation.dart';
import 'package:emigram/qlimatiq.dart';

const primary = const Color(0xFF1EC969);
const accent = const Color(0xFFE5FFE7);

Future<void> main() async {
  requestQlimatiqData();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Emigram',
    theme: ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: accent,
      ),
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar (title: const Text ("Emigram"),),
        body: Container(
            child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                      child: const Text.rich(
                          TextSpan(text:'Hi.\n \n', style: TextStyle(color: primary,fontSize: 64),
                              children: <TextSpan>[
                                TextSpan(text: 'Willkommen bei Emigram. Hier kannst du deine täglichen CO2 '
                                    'Emissionen errechnen lassen und bekommst so einen Einblick wie sich dein Verhalten '
                                    'auf deinen CO2-Fußabdruck auswirkt.', style: TextStyle(color: primary,fontSize: 24),
                                )
                              ]
                          )
                      )
                  ),
                  Container(
                      width: 320.0,
                      height: 40.0,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors:  <Color>[accent,primary]
                          )
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterScreen()));
                        },
                        child: const Text('LOS GEHTS!'),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0, 10,0, 0),
                      child: const Text('BEREITS REGISTRIERT?', style: TextStyle(color: Colors.black,fontSize: 15))
                  ),
                  Container(
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                        },
                        child: const Text('LOGIN'),
                      )
                  ),
                  Container(
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Geolocation()));
                        },
                        child: const Text('Current Location'),
                      )
                  ),
                ]
            )
        )
    );
  }
}

