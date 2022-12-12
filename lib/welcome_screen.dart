import 'dart:ui';

import 'package:flutter/material.dart';
const primary = const Color(0xFF1EC969);
const accent = const Color(0xFFE5FFE7);

void main() {
  runApp(MaterialApp(
    title: 'Testing stuff',
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
                      padding: EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 160.0),
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
                          //backgroundColor: MaterialStateProperty.all<Color>(primary)
                        ),
                        onPressed: () { },
                        child: const Text('LOS GEHTS!'),
                      )
                  ),
                  Container(
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                        ),
                        onPressed: () { },
                        child: const Text('BEREITS REGISTRIERT?'),
                      )
                  ),
                  Container(
                      child: TextButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                        ),
                        onPressed: () { },
                        child: const Text('LOGIN'),
                      )
                  )
                ]

            )
        )
    );
  }
}

