import 'package:firstapp/HomePage.dart';
import 'package:firstapp/Student/AnswerQuestion.dart';
import 'package:firstapp/Student/ShowLocation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

import 'StartExam.dart';

class MakeExam extends StatefulWidget {
  const MakeExam({Key? key, required this.exam, required this.counter})
      : super(key: key);

  final Exam exam;
  final int counter;

  @override
  State<MakeExam> createState() => _MakeExamState();
}

late Timer _timer;

class _MakeExamState extends State<MakeExam> with WidgetsBindingObserver {
  void startTimer() {
    try {
      if (_timer != null) {
        _timer.cancel();
      }
      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        if (counter > 0) {
          counter--;
        } else {
          _timer.cancel;
          addExam(widget.exam);
        }
      });
    } catch (e) {
      _timer = Timer.periodic(Duration(seconds: 2), (timer) {
        if (counter > 0) {
          counter--;
        } else {
          _timer.cancel;
          addExam(widget.exam);
        }
      });
    }

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (counter > 0) {
        counter--;
      } else {
        _timer.cancel;
        addExam(widget.exam);
      }
    });
  }

  int closedAppCounter = 0;
  @override
  initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      return;
    }
    final isbackGround = state == AppLifecycleState.paused;
    if (isbackGround) {
      closedAppCounter += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(widget.exam.studentAnswers);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: [
              Text('Select Question   ' + counter.toString()),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowLocation(
                                  lat: widget.exam.lat!,
                                  long: widget.exam.long!,
                                )));
                  },
                  child: const Text("Zie locatie"))
            ],
          )),
      floatingActionButton: ElevatedButton(
        child: const Text("Dien examen in"),
        onPressed: () {
          try {
            addExam(widget.exam)
                .then((value) => showToast("Exam was submitted succesfully"))
                .then((value) => print(widget.exam.studentAnswers))
                .then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: "Home"))));
          } catch (e) {
            print(e);
            showToast("Failed to upload exam.");
          }
        },
      ),
      body: StreamBuilder<List<Question>>(
          stream: getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              final students = snapshot.data!;

              return ListView(
                  children:
                      students.map((e) => buildExam(e, widget.exam)).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildExam(Question question, Exam exam) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AnswerQuestion(
                        question: question,
                        exam: exam,
                        counter: closedAppCounter,
                      )));
        },
        title: Text(question.question),
        subtitle: Text(question.options));
  }

// ignore: non_constant_identifier_names
  Stream<List<Question>> getQuestions() {
    Stream<List<Question>> questions = FirebaseFirestore.instance
        .collection('questions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Question.fromJson(doc.data(), doc.id))
            .toList());

    return questions;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  CollectionReference examColl = FirebaseFirestore.instance.collection('exams');

  Future<void> addExam(Exam exam) {
    exam.leftExam = widget.counter;
    return examColl
        .add(exam.toJson())
        .catchError((error) => throw ("Failed to add exam: $error"));
  }
}

class StudentAnswer {
  String id;
  final Question question;
  final String answer;

  StudentAnswer({this.id = ' ', required this.question, this.answer = ' '});

  Map<String, dynamic> toJson() => {
        'id': id,
        'question': question.toJson(),
        'answer': answer,
      };

  static StudentAnswer fromJson(Map<String, dynamic> json, String id) {
    return StudentAnswer(
      id: id,
      question: json['question'],
      answer: json['answer'],
    );
  }
}

class Exam {
  final String studentId;
  final List<StudentAnswer> studentAnswers;
  final double? lat;
  final double? long;
  final int score;
  final bool corrected;
  late int leftExam;

  String id;

  Exam(
      {this.id = ' ',
      required this.studentId,
      required this.studentAnswers,
      required this.lat,
      required this.long,
      this.score = 0,
      this.corrected = false,
      this.leftExam = 0});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> studentjson = [];
    for (var element in studentAnswers) {
      studentjson.add(element.toJson());
    }

    return {
      'id': id,
      'studentId': studentId,
      'studentAnswers': studentjson,
      'latitude': lat,
      'longitude': long,
      'score': score,
      'corrected': corrected,
      'leftExam': leftExam
    };
  }

  static Exam fromJson(Map<String, dynamic> json, String id) {
    return Exam(
        id: id,
        studentId: json['studentId'],
        studentAnswers: json['studentAnswers'],
        lat: json['latitude'],
        long: json['longitude'],
        score: json['score'],
        corrected: json['corrected'],
        leftExam: json['leftExam']);
  }
}
