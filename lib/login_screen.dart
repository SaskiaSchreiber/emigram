import 'package:flutter/material.dart';
import 'package:emigram/pw_forget_screen.dart';
import 'package:emigram/home_Screen.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

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
        title: const Text("Login"),
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
                  padding: const EdgeInsets.fromLTRB(10, 100.0,0, 40.0),
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
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Passwort'))),
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
                      //überprüfung der login daten
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PwForgetScreen()));
                    },
                    child: const Text('PASSWORT VERGESSEN?'),
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

