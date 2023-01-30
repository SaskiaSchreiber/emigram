import 'package:flutter/material.dart';
//import 'package:emigram/consum_profile_screen.dart';
import 'package:emigram/home_Screen.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class MobilityProfileScreen extends StatelessWidget{
  const MobilityProfileScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
        body:Home()
    );
  }
}

class _HomeState extends State<Home>{
  bool? checkBoxValue = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bewegungsprofil"),
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
                  padding: const EdgeInsets.fromLTRB(20, 20,20, 20.0),
                  child: const Text('Um deine CO2e Emissionen möglichst realistisch berechnen zu können brauchen wir ein paar Infos von dir:', style: TextStyle(color: primary,fontSize: 24))
              ),
              Column(
                children: [ Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          value: checkBoxValue,
                          activeColor: primary,
                          onChanged:(newbool){
                            setState(() {
                              checkBoxValue = newbool;
                            });
                          }),
                      const Text(' Ich habe einen PKW/ Ich fahre regelmäßig \n einen bestimmten PKW')
                    ],
                  ),
                ),],),
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ConsumProfileScreen()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                    },
                    child: const Text('WEITER'),
                  )
              ),
              Container(
                  child: TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black)
                    ),
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ConsumProfileScreen()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                    },
                    child: const Text('Später vielleicht...'),
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

