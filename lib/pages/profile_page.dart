import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:squares/pages/update_credentials_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  var userEmail = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Profile", style: TextStyle(color: Colors.purple),),
      ),
      body: FutureBuilder(
        future: initializeFirebase(),
        builder: (context, snapshot) => Center(
          child: SingleChildScrollView(
            child: Column(children: [
              Text("Welcome $userEmail"),
              FlatButton(
                child: Text("Update user credentials"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateCredentialsPage(userEmail)));
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  initializeFirebase() async {
    Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      userEmail = auth.currentUser.email;
    });
  }
}
