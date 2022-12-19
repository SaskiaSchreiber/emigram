import 'package:flutter/material.dart';
import 'package:emigram/login_screen.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class PwForgetScreen extends StatelessWidget{
  const PwForgetScreen({super.key});

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
        title: const Text("Passwort vergessen"),
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
                  child: const Text('Du hast dein Passwort vergessen?\n'
                      'Kein Problem! Gib deine E-Mail Adresse an und wir schicken dir eine E-Mail zum zurücksetzen deines Passworts.', style: TextStyle(color: primary,fontSize: 24))
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
                    ),)
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() ));
                    },
                    child: const Text('BESTÄTIGEN'),
                  )
              ),
              Container(
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                    ),
                    onPressed: () {
                      //push benachrichtigung einfügen;
                    },
                    child: const Text('Keine E-Mail erhalten?'),
                  )
              )
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

