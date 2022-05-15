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
  var _isLoading = false;

  Future<void> _onSubmit() async {
    setState(() => _isLoading = true);

    Position position = await _determinePosition();
    print(position);
    setState(() => _isLoading = false);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MakeExam(
                  exam: Exam(
                      studentId: widget.student.id,
                      studentAnswers: [],
                      lat: position.latitude,
                      long: position.longitude),
                  counter: 0,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(children: [
              const Text('Exam '),
              Text(widget.student.firstname +
                  " " +
                  widget.student.name +
                  " " +
                  widget.student.snumber)
            ], mainAxisAlignment: MainAxisAlignment.center)),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[800],
                        fixedSize: const Size(600, 110),
                        textStyle: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    icon: _isLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(Icons.play_circle),
                    label: const Text('Start Examen'),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
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
