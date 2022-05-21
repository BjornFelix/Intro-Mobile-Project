import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
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
  late int score; 
  int totalPoints = 0;
  List<dynamic> examAnswers = [];

  late Exam studentExam;
String examid='';
  late TextEditingController scoreController;
  @override
  void initState() {
    super.initState();
    score=0;
     scoreController = TextEditingController();
  }

  @override
  void dispose() {
    scoreController.dispose();
    super.dispose();
  }

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
          floatingActionButton:ElevatedButton(onPressed: () { studentExam.corrected=true;studentExam.score=score;studentExam.studentAnswers= examAnswers;

            studentExam.studentAnswers.forEach((element) => score+= StudentAnswer.fromJson(element, '').score ,);
            studentExam.score=score;
            updateExam(studentExam);
            
           },
          child: const Text("Bevestig verbetering")),
      body: FutureBuilder<List<Exam>>(
          future: getExam(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return const Text('Een fout heeft zich plaatsgevonden');
            } else if (snapshot.hasData) {
              final exam = snapshot.data!;
              studentExam=exam[0];
              examAnswers = exam[0].studentAnswers;

              return ListView(
                  children: examAnswers.map((e) => buildExam(e)).toList(),);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildExam(Map<String, dynamic> answer) {
    StudentAnswer ans = StudentAnswer.fromJson(answer, '');

    int points = ans.question.points;
 
    totalPoints += points;
    if (ans.question.type == 'CQ' ||
        ans.question.type == 'CC' ||
        ans.question.type == 'MC') {
      if (ans.answer.toUpperCase() == ans.question.answer.toUpperCase()) {
      
       
        ans.score=points;

        return ListTile(
            title: Text(ans.question.question),
            subtitle: Text(ans.answer +
                "       " +
                points.toString() +
                "/" +
                points.toString()));
      } else {
                ans.score=0;

        return ListTile(
            title: Text(ans.question.question),
            subtitle: Text(
                ans.answer + "           0/" + ans.question.points.toString()));
      }
    }
    else{
      if (ans.score== -1) { 
        return ListTile(
      title: Text(ans.question.question),
      subtitle:
          Text(ans.answer + "            0/"+ ans.question.points.toString()),
      onTap: () {
        openDialog(ans);
      },
    );
       
      }
        return ListTile(
      title: Text(ans.question.question),
      subtitle:
          Text(ans.answer + "          " + ans.score.toString()+'/' + ans.question.points.toString()),
     
    );
    }

    
  }

  Future openDialog(StudentAnswer answer) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Geef punten voor dit antwoord."),
            content: TextField(
                controller: scoreController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Geef hier de score in')),
            actions: [
              TextButton(
                  onPressed: () {
                    for (var i = 0; i < examAnswers.length; i++) {
                      StudentAnswer tempAnswer =
                          StudentAnswer.fromJson(examAnswers[i], '');
                      if (tempAnswer.question.id == answer.question.id) {
                        StudentAnswer correctedAnswer = StudentAnswer(
                            question: tempAnswer.question,
                            answer: tempAnswer.answer,
                            score: int.parse(scoreController.text.trim()));

                        examAnswers[i] = correctedAnswer.toJson();
                       
                        examAnswers = List.from( examAnswers);
                      }
                    }
                    submit();
                  },
                  child: const Text("Bevestig"))
            ],
          ));

  void submit() {
    Navigator.of(context).pop(scoreController.text);
  }

  Future<List<Exam>> getExam() async {
    var collection = FirebaseFirestore.instance.collection('exams');
    var querySnapshot = await collection.where('studentId',isEqualTo: widget.student.id).get();
    List<Exam> result = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
    
  examid=queryDocumentSnapshot.id;
  
      result.add(Exam.fromJson(data, queryDocumentSnapshot.id));
    }

    return result;
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

Future<void> updateExam(Exam exam) {
  CollectionReference exams = FirebaseFirestore.instance.collection('exams');

  return exams
    .doc(exam.id)
    .update(exam.toJson())
    .then((value) => showToast("Verbetering toegevoegd"))
    .catchError((error) => showToast("Failed to update exam: $error"));
}
}
