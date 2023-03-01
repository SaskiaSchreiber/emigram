//import 'dart:convert';

import "package:collection/collection.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class EmissionData {
  final double x;
  final double y;
  EmissionData({required this.x, required this.y});
}

List<EmissionData> get emissionData  {
  final data1 = <double>[];
  final f_daten={};
  User? newUser = FirebaseAuth.instance.currentUser;
  final emission = FirebaseDatabase.instance.ref();
  final userRef = emission.child("Emission/${newUser?.uid}");
  userRef.onValue.listen((DatabaseEvent event) {
    final daten = event.snapshot.value as Map<dynamic,dynamic>;
    if(daten != null){
      print(daten.runtimeType);
      for(var dat in daten.keys){
        var d = daten[dat] as Map<dynamic, dynamic>;
        double sum=0;
        for(var elt in d.keys){
          //print(d[elt]);
          sum= sum + d[elt];
        }
        f_daten[dat] = sum;
        data1.add(sum);
      }
      print(data1);//print(f_daten);
    }else{
      print("no data");
    }
  });

  //f_daten;
  return data1
      .mapIndexed(
      ((index, element)=> EmissionData(x: index.toDouble(), y: element)))
      .toList();
}

List<EmissionData> get yearDummy  {
  final data2 = <double>[2,4,6,11,3,6,4];
  print(data2);
  return data2
      .mapIndexed(
      ((index, element)=> EmissionData(x: index.toDouble(), y: element)))
      .toList();
  }