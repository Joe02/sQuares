import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateCredentialsPage extends StatefulWidget {
  final userEmail;

  UpdateCredentialsPage(this.userEmail);

  @override
  UpdateCredentialsPageState createState() => UpdateCredentialsPageState();
}

class UpdateCredentialsPageState extends State<UpdateCredentialsPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: initializeFirebase(),
        builder: (context, snapshot) => Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3.5),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: widget.userEmail,
                          labelText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "***********",
                          labelText: "Password",
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (passwordController.text.length > 5) {
                          submit();
                        }
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  initializeFirebase() async {
    Firebase.initializeApp();
  }

  submit() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    var emailError = "";
    var passwordError = "";

    user.updateEmail(emailController.text).then((_){
      print("Succesfully changed email");
    }).catchError((error){
      emailError = error.message;
      print("Email can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });

    user.updatePassword(passwordController.text).then((_){
      print("Succesfully changed password");
    }).catchError((error){
      passwordError = error.message;
      print("password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });

    if (emailError == "" && passwordError == "") {
      final snackBar = SnackBar(
        content: Text('User succesfully updated!'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Error updating your credentials.'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
