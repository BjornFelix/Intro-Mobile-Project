import 'dart:developer';
import 'dart:html';
import 'package:location/location.dart';
import 'package:firstapp/Student/MakeExam.dart';
import 'package:firstapp/Student/SelectQuestion.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';

class StartExam extends StatefulWidget {
  const StartExam({Key? key, required this.student}) : super(key: key);

  final Student student;
  @override
  State<StartExam> createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
  Location locationService = new Location();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Exam'),
              ],
            )),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(widget.student.firstname +
                      " " +
                      widget.student.name +
                      " " +
                      widget.student.snumber)
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      LocationData currentLocation = checkServiceEnabled(locationService).then((value) =>   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(
                                  exam: Exam(
                                      studentId: widget.student.id,
                                      studentAnswers: [], lat: value!.latitude, long: value.longitude),
                                )),
                      )) as LocationData;
                     
                    },
                    child: const Text('Start Examen'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[800],
                        padding: const EdgeInsets.fromLTRB(
                            338.0, 75.0, 338.0, 75.0)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

 Future<LocationData?> checkServiceEnabled(Location location) async {
  var serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (serviceEnabled) {
     return askPermission(location);
    }
  }
  if (serviceEnabled) {
     return askPermission(location);
    }
    return null;
  
}

Future<LocationData?> askPermission(Location location) async {
  var _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted == PermissionStatus.granted) {
       return getLocation(location);
    }
  }
   if (_permissionGranted == PermissionStatus.granted) {
       return getLocation(location);
    }
    return null;
}

Future<LocationData> getLocation(Location location) async {
  var currentLocation = await location.getLocation();
  print(currentLocation.toString());
  return currentLocation;
}
