import 'package:flutter/material.dart';

void main() {
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
        primarySwatch: Colors.blue,
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
          title: Text(widget.title),
        ),
        body: Center(


          child: Row(
            
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminRoute()),
                  );
                },

                child: const Text("Admin"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.all(100.0),
              
                ),
              ),

              ElevatedButton(
          
                onPressed: () {
                },

                child: const Text("Student"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[800],
                  padding: const EdgeInsets.all(100.0)
                ),
              ),
          ],
          )
           
        ));
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
                    padding: const EdgeInsets.fromLTRB(300.0,75.0,300.0,75.0)
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text('Studentenlijst'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[800],
                  padding: const EdgeInsets.fromLTRB(338.0,75.0,338.0,75.0)
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: const Text('Wachtwoord Wijzigen'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red[800],
                  padding: const EdgeInsets.fromLTRB(315.0,75.0,315.0,75.0)
                ),
              ),
            ],
        )
      )
    );
  }
}
