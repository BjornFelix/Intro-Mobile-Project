import 'package:firstapp/Admin/LoginPage.dart';
import 'package:firstapp/Student/AnswerQuestion.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;
import 'AdminHome.dart';
import 'CreateExam.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMultipleChoiceQuestion extends StatefulWidget {
  const AddMultipleChoiceQuestion({Key? key, required this.list})
      : super(key: key);

  final List<Question> list;
  @override
  State<AddMultipleChoiceQuestion> createState() =>
      _AddMultipleChoiceQuestionState();
}

 

class _AddMultipleChoiceQuestionState extends State<AddMultipleChoiceQuestion> {
  final questionController = TextEditingController();
  final optionsController = TextEditingController();
  final answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<Question> nList = [];

  @override
  void dispose() {
    questionController.dispose();
    optionsController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AdminRoute()));
      return false;
    },
    child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Voeg multiple choice vraag toe.'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vul tekst in';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Vraag")),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: optionsController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Opties"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul tekst in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul tekst in';
                      }
                      return null;
                    },
                    controller: answerController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Antwoord"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }
                          int totalPoints = 0;
                          for (var i = 0; i < nList.length; i++) {
                            totalPoints += nList[i].points;
                            print(totalPoints);
                          }
                          if(totalPoints>=20) {
                            showToast("Vraag toevoegen is mislukt, totaal aantal punten bereikt");
                          }
                          else {
                            nList.add(Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(),
                              options: optionsController.text.trim(),
                              points: 3,
                              type: 'MC',
                            )
                            );
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList,)),
                          );
                        }
                      },
                      child: const Text(
                        "Toevoegen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ))));
  }

  List<List> csvToList(String string) {
    csv.CsvToListConverter c =
        const csv.CsvToListConverter(fieldDelimiter: ",");
    List<List> listcreated = c.convert(string);
    return listcreated;
  }
}

class AddOpenQuestion extends StatefulWidget {
  const AddOpenQuestion({Key? key, required this.list}) : super(key: key);

  final List<Question> list;
  @override
  State<AddOpenQuestion> createState() => _AddOpenQuestionState();
}

class _AddOpenQuestionState extends State<AddOpenQuestion> {
  final questionController = TextEditingController();
  final optionsController = TextEditingController();
  final answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<Question> nList = [];

  @override
  void dispose() {
    questionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AdminRoute()));
      return false;
    },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Voeg open vraag toe'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vul tekst in';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Vraag")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }
                          int totalPoints = 0;
                          for (var i = 0; i < nList.length; i++) {
                            totalPoints += nList[i].points;
                             print(totalPoints);
                          }
                          if(totalPoints>=20) {
                            showToast("Vraag toevoegen is mislukt, totaal aantal punten bereikt");
                          }
                          else {
                            nList.add(Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(),
                              points: 2,
                              type: 'OQ',
                            )
                            );
                          }


                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList, )),
                          );
                        }
                      },
                      child: const Text(
                        "Toevoegen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ))));
  }
}

class AddClosedQuestion extends StatefulWidget {
  const AddClosedQuestion({Key? key, required this.list}) : super(key: key);

  final List<Question> list;
  @override
  State<AddClosedQuestion> createState() => _AddClosedQuestionState();
}

class _AddClosedQuestionState extends State<AddClosedQuestion> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<Question> nList = [];

  @override
  void dispose() {
    questionController.dispose();

    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AdminRoute()));
      return false;
    },
    child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Voeg gesloten vraag toe'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vul tekst in';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Vraag")),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul tekst in';
                      }
                      return null;
                    },
                    controller: answerController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Antwoord"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }
                          int totalPoints = 0;
                          for (var i = 0; i < nList.length; i++) {
                            totalPoints += nList[i].points;
                             print(totalPoints);
                          }
                          if(totalPoints>=20) {
                            showToast("Vraag toevoegen is mislukt, totaal aantal punten bereikt");
                          }
                          else {
                            nList.add(Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(),
                              points: 2,
                              type: 'CQ',
                            )
                            );
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList, )),
                          );
                        }
                      },
                      child: const Text(
                        "Toevoegen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ))));
  }
}

class AddCodeCorrection extends StatefulWidget {
  const AddCodeCorrection({Key? key, required this.list}) : super(key: key);

  final List<Question> list;
  @override
  State<AddCodeCorrection> createState() => _AddCodeCorrectionState();
}

class _AddCodeCorrectionState extends State<AddCodeCorrection> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<Question> nList = [];

  @override
  void dispose() {
    questionController.dispose();

    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AdminRoute()));
      return false;
    },
    child:  Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Voeg code correctie vraag toe'),
              ],
            )),
        floatingActionButton: ElevatedButton(
          child: const Text("Toevoegen"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              for (var element in widget.list) {
                nList.add(element);
              }
              int totalPoints = 0;
              for (var i = 0; i < nList.length; i++) {
                totalPoints += nList[i].points;
                 print(totalPoints);
              }
              if(totalPoints>=20) {
                showToast("Vraag toevoegen is mislukt, totaal aantal punten bereikt");
              }
              else {
                nList.add(Question(
                  question: questionController.text.trim(),
                  answer: answerController.text.trim(),
                  points: 2,
                  type: 'CC',
                  )
                );
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateExam(list: nList,)),
              );
            }
          },
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const SizedBox(width: 40),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vul tekst in';
                  }
                  return null;
                },
                controller: questionController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Vraag"),
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vul tekst in';
                  }
                  return null;

                },
                controller: answerController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Antwoord"),
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            const SizedBox(width: 20),
          ]),
        ))));
  }
}
