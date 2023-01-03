import 'package:emigram/emission_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'line_chart.dart';

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);
final scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
        body:Home()
    );
  }
}

class _HomeState extends State<Home>{

  bool _isVisible1 = true;
  bool _isVisible2 = true;

  void showHide1() {
    setState(() {
      _isVisible1 = !_isVisible1;
    });
  }

  void showHide2() {
    setState(() {
      _isVisible2 = !_isVisible2;
    });
  }

  @override
  Widget build(BuildContext context){
    final user= FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.person), //icon
          onPressed: (){
            if(scaffoldKey.currentState!.isDrawerOpen){
            scaffoldKey.currentState!.closeDrawer();
            //close drawer, if drawer is open
            }else {
              scaffoldKey.currentState!.openDrawer();
              //open drawer, if drawer is closed
            }
          },
        )
      ),
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: primary,
              ),
              child: Text(user.email!)//Text('Max Mustermann'), // User-spezifische Email(später mit Nach und Vorname)
            ),
            ListTile(
              title: const Text('Konto bearbeiten'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Mobilitätsprofil anpassen'),
              onTap: () {
                showHide1();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Konsumprofil anpassen'),
              onTap: () {
                showHide2();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Farbschema anpassen'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                //Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
              },
            ),
          ],
        ),
      ),
      body: content(),
    );
  }
  Widget content() {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              const SizedBox(height: 20),
              Visibility(
                visible: _isVisible2,
                child: Container(
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
                      showHide2();
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                    },
                    child: const Text('Plaid aktivieren'),
                  )
              ),),
              const SizedBox(height: 20),
              Visibility(
                visible: _isVisible1,
                child: Container(
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
                        showHide1();
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
                      },
                      child: const Text('Googlemaps aktivieren'),
                    )
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 40),
                  const Text('Deine Emmisionen letzten Monat', style: TextStyle(color: primary,fontSize: 24)),
                  const SizedBox(height: 10),
                  LineChartWidget(emissionData),
                  const SizedBox(height: 40),
                  const Text('Deine Emmisionen letztes Jahr', style: TextStyle(color: primary,fontSize: 24)),
                  const SizedBox(height: 10),
                  LineChartWidget(emissionData),
                ],
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

