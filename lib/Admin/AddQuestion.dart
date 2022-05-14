import 'package:firstapp/Student/AnswerQuestion.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Add multiple choice question'),
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
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Question")),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: optionsController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Options"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: answerController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Answer"),
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

                          Question question = Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(),
                              options: optionsController.text.trim(), type: 'MC');

                          nList.add(question);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList)),
                          );
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            )));
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Add open question'),
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
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Question")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }
                          nList.add(Question(
                              question: questionController.text.trim(), type: 'OQ'));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList)),
                          );
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            )));
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Add multiple choice question'),
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
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Question")),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: answerController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Answer"),
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
                          nList.add(Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(), type: 'CQ'));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList)),
                          );
                        }
                      },
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            )));
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Add code correction question'),
              ],
            )),
        floatingActionButton: ElevatedButton(
          child: const Text("Add"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              for (var element in widget.list) {
                nList.add(element);
              }
              nList.add(Question(
                question: questionController.text.trim(),
                answer: answerController.text.trim(), 
                type: 'CC',
              ));

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateExam(list: nList)),
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
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: questionController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Question"),
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
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: answerController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Answer"),
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            const SizedBox(width: 20),
          ]),
        )));
  }
}
