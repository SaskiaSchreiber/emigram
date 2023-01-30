import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:emigram/pw_forget_screen.dart';
import 'package:emigram/home_Screen.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context)=>//{
     Scaffold(
        body:StreamBuilder<User?>( // Checkt, ob der User immer eingeloggt ist
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if (snapshot.hasData){
              return  const HomeScreen(); // Ja : Home Screen
            }else{
              return const Home(); // Nein: Login Screen
            }
          }
        )
    );
  //}
}

class _HomeState extends State<Home>{

  //Texfied Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // dispose überschreiben
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
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
                  padding: const EdgeInsets.fromLTRB(10, 40.0,0, 40.0),
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
                    SizedBox(height: 10),
                    SizedBox(
                        width: 390,
                        child: TextField(
                          controller: passwordController, // controller hinzugefügt
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
                    onPressed: () async{
                      //überprüfung der login daten
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
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

