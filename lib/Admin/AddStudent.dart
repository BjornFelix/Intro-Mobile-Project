import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AdminHome.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({Key? key}) : super(key: key);

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final csvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    csvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text('Add Students'),
          actions: [
            ElevatedButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text("Sign out")),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(200.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: csvController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        labelText: "Add csv here ( firstname, name, s-number)"),
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          csvToList(csvController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmStudentsPage(
                                      list: csvToList(csvController.text),
                                    )),
                          );
                        }
                      },
                      child: const Text("Submit"),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
                    )
                  ])
                ],
              ),
            )));
  }

  List<List> csvToList(String string) {
    csv.CsvToListConverter c =
        const csv.CsvToListConverter(eol: "\n", fieldDelimiter: ",");
    List<List> listcreated = c.convert(string);

    
    return listcreated;
  }
}

class ConfirmStudentsPage extends StatefulWidget {
  const ConfirmStudentsPage({Key? key, required this.list}) : super(key: key);

  final List<List> list;

  @override
  _ConfirmStudentsState createState() => _ConfirmStudentsState();
}

class _ConfirmStudentsState extends State<ConfirmStudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Confirm students'),
        ),
        floatingActionButton: ElevatedButton(
          child: const Text("Confirm"),
          onPressed: () {
            for (var i = 0; i < widget.list.length; i++) {
              try {
                addStudent(widget.list[i]);
              } catch (e) {
                showToast("Failed adding students");
              }
              
            }
            showToast("Added students succesfully");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdminRoute()));
          },
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.all(2),
                color: Colors.grey[400],
                child: Center(
                    child: Text(
                  'Name: ${widget.list[index][1]} FirstName: ${widget.list[index][0]}  S-Number: ${widget.list[index][2]} ',
                  style: const TextStyle(fontSize: 18),
                )),
              );
            }));
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
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(List student) {
    return students.add({
      'name': student[1],
      'firstname': student[0],
      'snumber': student[2]
    }).catchError((error) => throw ("Failed to add user: $error"));
  }
}

//class CsvToList extends StatefulWidget {
//  const CsvToList({Key? key}) : super(key: key);

//  @override
//  State<StatefulWidget> createState() {
//  return CsvToListState();
//  }
//}

//class CsvToListState extends State<CsvToList> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          backgroundColor: Colors.red[800],
//        title: const Text('Add students'),
//          actions: [
//            ElevatedButton(
//                onPressed: () => FirebaseAuth.instance.signOut(),
//                child: const Text("Sign out")),
//          ],
//        ),
//        body: Container(
//            constraints: const BoxConstraints(maxWidth: 400),
//            padding: const EdgeInsets.all(32),
//            alignment: Alignment.center,
//            child: Column(
//              children: [
//                ElevatedButton(
//                  child: const Text("Pick File"),
//                  onPressed: () async {
//                    FilePickerResult? result =
//                        await FilePicker.platform.pickFiles();
//
//                    if (result != null) {
//                      Uint8List? data = result.files.first.bytes;
//                    //not for web
//                     //String? path = result.files.first.path;
//                     //File file = File(path!);
//                     //csvToList(file);
//                      print(data);
//                    } else {
//                      // User canceled the picker
//                    }
//                  },
//                )
//              ],
//            )));
//  }

// //not Web
//  List<List> csvToList(File file) {
//    csv.CsvToListConverter c =
//        const csv.CsvToListConverter(fieldDelimiter: ',');
//
//    List<List> listCreated = c.convert(file.readAsStringSync());
//    return listCreated;
//  }
//}