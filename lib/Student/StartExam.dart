import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'MakeExam.dart';

class StartExam extends StatefulWidget {
  const StartExam({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  State<StartExam> createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
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
                    onPressed: () async {
                      Position position = await _determinePosition();
                      print(position);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              MakeExam(
                                exam: Exam(
                                    studentId: widget.student.id,
                                    studentAnswers: [],
                                    lat: position.latitude,
                                    long: position.longitude),
                              ))
                      )
                      ;
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
