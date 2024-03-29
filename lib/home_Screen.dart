import 'package:emigram/emission_data.dart';
import 'package:emigram/mock_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'line_chart.dart';
import 'line_chart_dummy.dart';
import "emission_tracking_screen.dart";

const primary = Color(0xFF1EC969);
const accent = Color(0xFFE5FFE7);
final scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Home());
  }
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.person), //icon
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                scaffoldKey.currentState!.closeDrawer();
                //close drawer, if drawer is open
              } else {
                scaffoldKey.currentState!.openDrawer();
                //open drawer, if drawer is closed
              }
            },
          )),
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[accent, primary])),
                child: Text(user
                    .email!) //Text('Max Mustermann'), // User-spezifische Email(später mit Nach und Vorname)
                ),
            CustomListTile(Icons.edit, 'Konto bearbeiten', () {
              Navigator.pop(context);
            }),
            CustomListTile(Icons.car_rental, 'Mobilitätsprofil anpassen', () {
              //showHide1();
              Navigator.pop(context);
            }),
            CustomListTile(Icons.fastfood, 'Konsumprofil anpassen', () {
              //showHide2();
              Navigator.pop(context);
            }),
            CustomListTile(Icons.car_rental, 'Emissionen aufzeichnen', () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmissionTrackingScreen()));
            }),
            CustomListTile(Icons.colorize, 'Farbschema anpassen', () {
              Navigator.pop(context);
            }),
            CustomListTile(Icons.lock, 'Logout', () {
              FirebaseAuth.instance.signOut();
              //Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);
            }),
          ],
        ),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(15),
          children: <Widget>[
            const Text.rich(
                TextSpan(text:'So gehts:\n \n', style: TextStyle(color: primary,fontSize: 24),
                    children: <TextSpan>[
                      TextSpan(text: 'Wenn du mit dem Auto unterwegs bist, starte den Emissionentracker um '
                          'deinen Verbrauch von Emigram errechnen zulassen. Klicke dazu im Menü (Personicon '
                          'oben links in der Ecke) auf "Emissionen aufzeichnen"',
                        style: TextStyle(
                            color: primary,
                            fontSize: 18),
                      )
                    ]
                )
            ),
            Column(
              children: [
                const SizedBox(height: 40),
                const Text('Deine Emissionen letzten Monat',
                    style: TextStyle(color: primary, fontSize: 24)),
                const SizedBox(height: 10),
                LineChartWidget(emissionData),
                const SizedBox(height: 40),
                const Text('Deine Emissionen letztes Jahr',
                    style: TextStyle(color: primary, fontSize: 24)),
                const SizedBox(height: 10),
                Padding (
                    padding: EdgeInsets.all(4.0),
                    child: LineChartWidgetDummy(mockData)
                )
              ],
            ),
        ]),
      );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: primary,
          onTap: onTap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

