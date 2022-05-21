import 'package:firstapp/Student/AnswerQuestion.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AddQuestion.dart';
import 'AdminHome.dart';

class CreateExam extends StatefulWidget {
  const CreateExam({Key? key, required this.list}) : super(key: key);

  final List<Question> list;

  @override
  State<CreateExam> createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  List<Question> dbquestion = [];
  int totalPoints = 0;

  @override
  void initState() {
    for (var i = 0; i < widget.list.length; i++) {
      totalPoints += widget.list[i].points;
      print(totalPoints);
    }

    getQuestions().then((value) => print(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text('Voeg examen vragen toe'),
          actions: [
            ElevatedButton(
                onPressed: () => {
                      FirebaseAuth.instance
                          .signOut()
                          .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AdminRoute()),
                              ))
                    },
                child: const Text("Log uit")),
          ],
        ),
        body: Column(
          children: <Widget>[
            Text(totalPoints.toString() + "/20"),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: dbquestion.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        margin: const EdgeInsets.all(2),
                        color: Colors.grey[400],
                        child: Row(
                          children: [
                            Center(
                                child: Text(
                              'Vraag: ${dbquestion[index].question}    Antwoord: ${dbquestion[index].answer} ',
                              style: const TextStyle(fontSize: 18),
                            )),
                            ElevatedButton.icon(
                                onPressed: deleteDBQuestion(dbquestion[index]),
                                icon: const Icon(Icons.delete),
                                label: const Text("Verwijder"))
                          ],
                        ));
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.all(2),
                      color: Colors.grey[400],
                      child: Center(
                          child: Text(
                        'Vraag: ${widget.list[index].question}       Antwoord: ${widget.list[index].answer} ',
                        style: const TextStyle(fontSize: 18),
                      )),
                    );
                  }),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddMultipleChoiceQuestion(list: widget.list)),
                      );
                    },
                    child: const Text('Multiple choice'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddOpenQuestion(list: widget.list)),
                      );
                    },
                    child: const Text('Open vraag'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddClosedQuestion(list: widget.list)),
                      );
                    },
                    child: const Text('Gesloten vraag'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddCodeCorrection(list: widget.list)),
                      );
                    },
                    child: const Text('Code correctie'),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    child: const Text("Examen indienen"),
                    onPressed: () {
                      int totalPoints = 0;
                      for (var i = 0; i < widget.list.length; i++) {
                        totalPoints += widget.list[i].points;
                      }
                      for (var i = 0; i < widget.list.length; i++) {
                        try {
                          AddQuestion(widget.list[i], totalPoints);
                        } catch (e) {
                          showToast("Mislukt vraag toe te voegen");
                        }
                      }
                      showToast("Examen is succesvol ingediend");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminRoute()));
                    },
                  ),
                ],
              ),
            )
          ],
        ));
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

  deleteDBQuestion(Question question) {
    FirebaseFirestore.instance
        .collection('questions')
        .doc(question.id)
        .delete();
  }

  Future<List<Question>> getQuestions() async {
    List<Question> questionsList = [];
    Stream<List<Question>> questions = FirebaseFirestore.instance
        .collection('questions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Question.fromJson(doc.data(), doc.id))
            .toList());
    return questions.elementAt(0);
  }

  CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  // ignore: non_constant_identifier_names
  Future<void> AddQuestion(Question question, int points) async {
    if (points >= 20) {
    } else {
      questions.add(question.toJson());
    }
  }
}
