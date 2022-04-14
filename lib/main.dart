import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDmvRKhdCnPR1ZmUmJ6YoNzFZ9wx4998D0',
          appId: 'project-425922472925',
          messagingSenderId: '425922472925',
          projectId: 'intromobile-740ff'));
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: Colors.red[800]),
      ),
      home: const MyHomePage(title: 'Intro Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: [
                Image.asset(
                  'assets/AP_logo_basis.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(widget.title))
              ],
            )),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text("Admin"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red[800],
                padding: const EdgeInsets.all(100.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Student"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.all(100.0)),
            ),
          ],
        )));
  }
}

class AdminRoute extends StatelessWidget {
  const AdminRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text('Admin Route'),
          actions: [
            ElevatedButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text("Sign out")),
          ],
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Examenvragen aanmaken'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.fromLTRB(300.0, 75.0, 300.0, 75.0)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddStudents()),
                );
              },
              child: const Text('Studentenlijst'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.fromLTRB(338.0, 75.0, 338.0, 75.0)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Wachtwoord Wijzigen'),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.fromLTRB(315.0, 75.0, 315.0, 75.0)),
            ),
          ],
        )));
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Admin Login'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Email")),
                const SizedBox(height: 4),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: signIn,
                    icon: const Icon(
                      Icons.lock_open,
                      size: 32,
                    ),
                    label: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            )));
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const AdminRoute();
          } else {
            return const LoginWidget();
          }
        });
  }
}

class AddStudents extends StatefulWidget {
  const AddStudents({Key? key}) : super(key: key);

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final csvController = TextEditingController();

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
            child: Column(
              children: [
                TextField(
                  controller: csvController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: "Add csv here ( firstname, name, s-number)"),
                  minLines:6, 
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                    onPressed: () {
                      csvToList(csvController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmStudentsPage(
                                  list: csvToList(csvController.text),
                                )),
                      );
                    },
                    child: const Text("Submit"),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
                  )
                ])
              ],
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
              AddStudent(widget.list[i]);

            }
            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminRoute( )));
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

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  // ignore: non_constant_identifier_names
  Future<void> AddStudent(List student) {
    return students.add({
      'name': student[1],
      'lastname': student[0],
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
