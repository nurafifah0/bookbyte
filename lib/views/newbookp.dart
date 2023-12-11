import 'package:bookbyte/models/user.dart';
import 'package:flutter/material.dart';

class NewBookPage extends StatefulWidget {
  final User userdata;

  const NewBookPage({super.key, required this.userdata});

  @override
  State<NewBookPage> createState() => _NewBookPageState();
}

class _NewBookPageState extends State<NewBookPage> {
  late double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text("New Book")),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text("hello world"),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        // FloatingActionButtonLocation.centerDocked;
        /* {
           Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const ContactList())); 
        }, */

        tooltip: 'Add',
        //heroTag: 'uniqueTag',
        child: Icon(Icons.add),
      ),
    );
  }

  handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  additem(item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
