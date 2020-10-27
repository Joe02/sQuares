import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.person_sharp,
              size: 20,
              color: Colors.deepPurple[200],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "sQuares",
            style: TextStyle(color: Colors.deepPurple[300]),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.settings,
                color: Colors.deepPurple[200],
                size: 20,
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white,
                Colors.deepPurple[100],
                Colors.deepPurple[200],
              ])),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: GridView.count(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 5
                        : 4,
                children: List.generate(
                    25,
                    (index) => Card(
                          elevation: 5,
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
              ),
            ),
          ),
        ));
  }
}
