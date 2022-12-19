import 'package:flutter/material.dart';
import 'package:emigram/mobility_profile_screen.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
        body:Home()
    );
  }
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrierung"),
        automaticallyImplyLeading: true,
      ),
      body: content(),
    );
  }
  Widget content() {
    return Scaffold(
              body: SafeArea(
                child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(10, 160.0,0, 40.0),
                          child: const Text('Emigram', style: TextStyle(color: primary,fontSize: 50))
                      ),
                      Column(
                          children: const [
                            SizedBox(
                                width: 390,
                                child: TextField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail Adresse')
                              )),
                            SizedBox(height: 10),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Vorname'))),
                            SizedBox(height: 10),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nachname'))),
                            SizedBox(height: 10),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Passwort'))),
                            SizedBox(height: 10),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Passwort bestätigen'))),
                          ]),
                      const SizedBox(height: 40),
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MobilityProfileScreen() ));
                            },
                            child: const Text('REGISTRIEREN'),
                          )
                      ),
                    ]
                ),
              ),
          );
  }
}

class Home extends StatefulWidget{
  const Home({Key? key}) : super (key: key);

  @override
  State<Home> createState() => _HomeState();
}

