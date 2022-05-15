import 'dart:developer';

import 'package:firstapp/Student/MakeExam.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Student/AnswerQuestion.dart';

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key, required this.student}) : super(key: key);

  final Student student;
  @override
  State<CorrectExam> createState() => _CorrectExamState();
}



class _CorrectExamState extends State<CorrectExam> {
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Selecteer student'),
            ],
          )),
      body: FutureBuilder<List<Exam>>(
          future: getExam(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return const Text('Een fout heeft zich plaatsgevonden');
            } else if (snapshot.hasData) {
              final exam = snapshot.data!;
              final answers = exam[0].studentAnswers;
              return ListView(
                  children: answers.map((e) => buildExam(e)).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildExam(StudentAnswer answer) {
    int points = answer.question.points;

    if (answer.question.type == 'CQ' || answer.question.type == 'CC' ||
        answer.question.type == 'MC') {
      if (answer.answer.toUpperCase() == answer.question.answer) {
        score += points;
        return ListTile(

            title: Text(answer.question.question),
            subtitle: Text(
                answer.answer + points.toString() + "/" + points.toString())
        );
      }
      else {
        return ListTile(

            title: Text(answer.question.question),
            subtitle: Text(
                answer.answer + "0/" + answer.question.points.toString())
        );
      }
    }
    return ListTile(

        onTap: () {},
        title: Text(answer.question.question),
        subtitle: Text(answer.answer)
    );
  }


  Future <List<Exam>> getExam() async {
    var collection = FirebaseFirestore.instance.collection('exams');
    var querySnapshot = await collection.get();
    List<Exam> result = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      data["studentId"] = queryDocumentSnapshot.id;
      result.add(Exam.fromJson(data, queryDocumentSnapshot.id));
      }
    print(result.toString());
    return result;
  }
}