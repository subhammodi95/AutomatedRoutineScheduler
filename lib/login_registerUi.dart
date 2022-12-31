import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './loginUi.dart';
import 'tutor_registerUi.dart';

class LoginRegisterUi extends StatefulWidget {
  @override
  _LoginRegisterUiState createState() => _LoginRegisterUiState();
}

class _LoginRegisterUiState extends State<LoginRegisterUi> {
  String who = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "as",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          who = "admin";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginUi(who: who)));
                        },
                        color: Colors.grey.shade700,
                        elevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Admin",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          who = "tutor";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginUi(who: who)));
                        },
                        color: Colors.red,
                        elevation: 0,
                        highlightColor: Colors.red.withOpacity(0.3),
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Tutor",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "as",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminRegisterUi()));
                    },
                    color: Colors.grey.shade700,
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterUi(),
                        ),
                      );
                    },
                    color: Colors.red,
                    elevation: 0,
                    highlightColor: Colors.red.withOpacity(0.3),
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Tutor",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
