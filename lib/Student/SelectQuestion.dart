import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Admin/SelectStudent.dart';

class SelectQuestion extends StatefulWidget {
  const SelectQuestion({Key? key,required this.student}) : super(key: key);

  final Student student;
  @override
  State<SelectQuestion> createState() => _SelectQuestionState();
}

class _SelectQuestionState extends State<SelectQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Select Question'),
            ],
          )),
      body: StreamBuilder<List<Question>>(
          stream: getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              final students = snapshot.data!;

              return ListView(
                  children: students.map((e) => buildQuestion(e)).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildQuestion(Question question) {
    return ListTile(
        title: Text(question.question),
        subtitle: Text(question.options ));
  }

// ignore: non_constant_identifier_names
  Stream<List<Question>> getQuestions() {
    return FirebaseFirestore.instance.collection('Exam').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Question.fromJson(doc.data(), doc.id))
            .toList());
  }
}

