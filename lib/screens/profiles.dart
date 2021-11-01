import 'package:flutter/material.dart';
import 'dart:convert';

class Profiles extends StatefulWidget { 

  @override
  _Profiles createState() => _Profiles();
}

class _Profiles extends State<Profiles>{
final List nama = [
    "Saipul Anwar",
    "Abdullah Azzam",
    "Muhammad Anandito",
    "Fitri Mardiana"

  ];

  final List nim = [
    "21120119120034",
    "21120119130047",
    "21120119130082",
    "21120119130112",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KELOMPOK 30'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
  itemBuilder: (context, index) {
    return Card(
      child: ListTile(
          title: Text(
            nama[index], 
            style: TextStyle(fontSize: 30)
          ),
          subtitle: Text(nim[index]),
          leading: CircleAvatar(
            child: Text(
              nama[index][0], // ambil karakter pertama text
              style: TextStyle(fontSize: 20)
            ),
          )
      ),
    );
  },
  itemCount: nama.length,
    )
    );

}
}
