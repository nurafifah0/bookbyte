
import 'package:bookbyte/models/user.dart';
import 'package:bookbyte/shared/mydrawer.dart';
import 'package:bookbyte/views/newbookp.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final User userdata;
  const MainPage({super.key, required this.userdata});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //List<Book> bookList = <Book>[];
  late double screenWidth, screenHeight;
  @override
  void initState() {
    super.initState();
    //  loadBooks();
  }

  int axiscount = 2;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //CircleAvatar(backgroundImage: AssetImage('')),
              Text(
                "Book List",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 40,
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey,
              height: 1.0,
            ),
          )),
      drawer: MyDrawer(
        page: "books",
        userdata: widget.userdata,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text("welcome to the book byte"),
              SizedBox(
                height: 30,
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newBook,
        child: const Icon(Icons.add),
      ),
    );
  }

  void newBook() {
    if (widget.userdata.userid.toString() == "0") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please register an account"),
        backgroundColor: Colors.red,
      ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) => NewBookPage(
                    userdata: widget.userdata,
                  )));
    }
  }

  String truncateString(String str) {
    if (str.length > 20) {
      str = str.substring(0, 20);
      return "$str...";
    } else {
      return str;
    }
  }

/*   void loadBooks() {
    http.get(Uri.parse("${ServerConfig.server}/bookbytes/php/load_books.php"),
        headers: {
          //get array
        }).then((response) {
      //log(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          bookList.clear();
          data['data']['books'].forEach((v) {
            bookList.add(Book.fromJson(v));
          });
        } else {
          //if no status failed
        }
      }
      setState(() {});
    });
  } */
}
