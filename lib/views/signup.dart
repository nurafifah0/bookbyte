// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookbyte/shared/serverconfig.dart';
import 'package:bookbyte/views/login.dart';
import 'package:bookbyte/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//void main() => runApp(MaterialApp(const SignUpPage());

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String eula = "";
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        /* bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          ), */
        leading: BackButton(
          onPressed: () {
            //Navigator.of(context).pop();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (content) => const Homepage()));
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(197, 233, 179, 207),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: Image.asset(
                    'assets/images/p1.png',
                    alignment: const Alignment(100, 100),
                  ),
                ),
                /* IconButton(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    tooltip: 'Go back',
                    enableFeedback: true,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (content) => const Homepage()));
                    },
                  ), */

                const SizedBox(
                  width: 400,
                  height: 50,
                  child: Text(
                    "Sign Up",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // textAlign: TextAlign.center,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: "e.g John",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      // prefixText: '\$: ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (val) => val!.isEmpty || (val.length < 3)
                      ? "name must be longer than 3"
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'email',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      hintText: "    e.g john01@gmail.com",
                      //suffixText: 'Year(s)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (val) =>
                      val!.isEmpty || !val.contains("@") || !val.contains(".")
                          ? "enter a valid email"
                          : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // textAlign: TextAlign.center,
                  controller: newPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: 'New Password',
                      hintText: "e.g As21@364",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      //prefixText: '\$: ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (val) => validatePassword(val.toString()),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 20),
                      hintText: "e.g As21@364",
                      //suffixText: 'Year(s)',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  validator: (val) => validatePassword(val.toString()),
                ),
                const SizedBox(
                  height: 70,
                  // width: 100,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                    ),
                    ElevatedButton(
                        onPressed: _reset,
                        child: const Text(
                          "Reset",
                          style: TextStyle(fontSize: 20),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: _registerUserDialog
                      /* {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const Homepage()));
                        }, */
                      /* {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => const Homepage()));
                        }, */
                      ,
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 80,
                    ),
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    GestureDetector(
                        onTap: _showEULA,
                        child: const Text("Agree with terms?")),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _reset() {
    nameController.clear();
    emailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void _registerUserDialog() {
    String pass = newPasswordController.text;
    String pass2 = confirmPasswordController.text;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please accept EULA"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (pass != pass2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password do not match!!!"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Registration Canceled"),
                  backgroundColor: Colors.red,
                ));
              },
            ),
          ],
        );
      },
    );
  }

  loadEula() async {
    eula = await rootBundle.loadString('assets/eula.txt');
  }

  void _showEULA() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
            style: TextStyle(),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.black),
                        text: eula),
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _registerUser() {
    String name = nameController.text;
    String email = emailController.text;
    String pass = newPasswordController.text;

    http.post(
        Uri.parse("${ServerConfig.server}/bookbyte/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "password": pass
        }).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Success"),
            backgroundColor: Colors.green,
          ));
          Navigator.push(context,
              MaterialPageRoute(builder: (content) => const LoginPage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
