import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'AdminHome.dart';

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
<<<<<<< Updated upstream
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
=======
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Voeg tekst in';
                        }
                        return null;
                      },
                      controller: emailController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Email")),
                  const SizedBox(height: 4),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voeg tekst in';
                      }
                      return null;
                    },
                    controller: passwordController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Wachtwoord"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signIn();
                        }
                      },
                      icon: const Icon(
                        Icons.lock_open,
                        size: 32,
                      ),
                      label: const Text(
                        "Inloggen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
>>>>>>> Stashed changes
            )));
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
<<<<<<< Updated upstream
        password: passwordController.text.trim());
=======
        password: passwordController.text.trim());}catch(err){
          
          showToast("Login mislukt");
        }
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
            showToast("Login gelukt");
>>>>>>> Stashed changes
            return const AdminRoute();
          } else {
            return const LoginWidget();
          }
        });
  }
}