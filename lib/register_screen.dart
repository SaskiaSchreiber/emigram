import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
  //Texfield Controller
  final vornameController = TextEditingController();
  final nachnameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final pwdbController = TextEditingController();

 //dispose überschreiben
  @override
  void dispose() {
    vornameController.dispose();
    nachnameController.dispose();
    emailController.dispose();
    pwdbController.dispose();
    pwdController.dispose();
    super.dispose();
  }

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
                          padding: const EdgeInsets.fromLTRB(10, 10,0, 10.0),
                          child: const Text('Emigram', style: TextStyle(color: primary,fontSize: 50))
                      ),
                      Column(
                          children:  [
                            SizedBox(
                                width: 390,
                                child: TextField(
                                  controller: emailController, // controller hinzugefügt
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail Adresse')
                              )),
                            SizedBox(height: 5),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                  controller: vornameController, // controller hinzugefügt
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Vorname'))),
                            SizedBox(height: 5),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                  controller: nachnameController, // controller hinzugefügt
                                obscureText: false,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nachname'))),
                            SizedBox(height: 5),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                  controller: pwdController, // controller hinzugefügt
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Passwort'))),
                            SizedBox(height: 5),
                            SizedBox(
                                width: 390,
                                child: TextField(
                                  controller: pwdbController, // controller hinzugefügt
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Passwort bestätigen'))),
                          ]),
                      const SizedBox(height: 20),
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
                            onPressed: () async {

                              //Registrierung Funktion mit Verbidung zu Realtime Database
                                if(pwdbController.text.trim()==pwdController.text.trim()){
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: emailController.text.trim(),
                                        password: pwdbController.text.trim()
                                    ).then((value) async {
                                        User? newUser = FirebaseAuth.instance.currentUser;
                                        final database = FirebaseDatabase.instance.ref();
                                        final userRef = database.child("User/${newUser?.uid}");
                                        userRef.set({"email":emailController.text.trim(),
                                                        "vorname":vornameController.text.trim(),
                                                        "nachname":nachnameController.text.trim()
                                                        });

                                      });



                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MobilityProfileScreen() ));
                                }
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

