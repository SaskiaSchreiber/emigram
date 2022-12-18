import 'package:flutter/material.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class ConsumProfileScreen extends StatelessWidget{
  const ConsumProfileScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
        body:Home()
    );
  }
}

class _HomeState extends State<Home>{
  bool? checkBoxValue1 = false;
  bool? checkBoxValue2 = false;
  bool? checkBoxValue3 = false;
  bool? checkBoxValue4 = false;
  bool? checkBoxValue5 = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konsumprofil"),
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
                  padding: EdgeInsets.fromLTRB(10, 0,0, 0),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          value: checkBoxValue1,
                          activeColor: primary,
                          onChanged:(newbool){
                            setState(() {
                              checkBoxValue1 = newbool;
                            });
                          }),
                      const Text('vegan')
                    ],
                  ),
                ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0,0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: checkBoxValue2,
                            activeColor: primary,
                            onChanged:(newbool){
                              setState(() {
                                checkBoxValue2 = newbool;
                              });
                            }),
                        const Text('vegetarisch')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0,0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: checkBoxValue3,
                            activeColor: primary,
                            onChanged:(newbool){
                              setState(() {
                                checkBoxValue3 = newbool;
                              });
                            }),
                        const Text('fleischbetont')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0,0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: checkBoxValue4,
                            activeColor: primary,
                            onChanged:(newbool){
                              setState(() {
                                checkBoxValue4 = newbool;
                              });
                            }),
                        const Text('fleischreduziert')
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0,0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                            value: checkBoxValue5,
                            activeColor: primary,
                            onChanged:(newbool){
                              setState(() {
                                checkBoxValue5 = newbool;
                              });
                            }),
                        const Text('mischkost')
                      ],
                    ),
                  ),
                ],),
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
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

