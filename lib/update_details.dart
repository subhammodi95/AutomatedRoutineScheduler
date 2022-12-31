import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import './all_data.dart';
import './widgets/register.dart';

class UpdateUi extends StatefulWidget {
  @override
  _UpdateUiState createState() => _UpdateUiState();
}

class _UpdateUiState extends State<UpdateUi> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController teacher_name =
      TextEditingController(text: teacher_user_data['userName']);
  TextEditingController teacher_code =
      TextEditingController(text: teacher_user_data['code']);
  TextEditingController teacher_email =
      TextEditingController(text: teacher_user_data['email']);
  TextEditingController teacher_password =
      TextEditingController(text: teacher_user_data['password']);
  TextEditingController admin_id =
      TextEditingController(text: teacher_user_data['admin_id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "as Teacher",
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: teacher_name,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your name";
                              } else if (msg.length < 3) {
                                return "Name too short";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.people,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: teacher_code,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your code";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.code,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Teacher Code",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: teacher_email,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your email";
                              } else if (msg.length < 5) {
                                return "Invalid email address";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: teacher_password,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your password";
                              } else if (msg.length < 4) {
                                return "Password too weak";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg != teacher_password.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: admin_id,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your admin id";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.privacy_tip_outlined,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Enter Admin ID",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Updating, Please Wait!",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.amber,
                                ),
                              );
                              String status = await update_teacher(
                                  teacher_user_data["u_id"],
                                  teacher_name.text,
                                  teacher_code.text,
                                  teacher_email.text,
                                  teacher_password.text,
                                  admin_id.text,
                                  context);
                              if (status == "Success") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Details Updated",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      status,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          color: Colors.red.shade700,
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
                                "Update",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//====================================================

class AdminUpdateUi extends StatefulWidget {
  @override
  _AdminUpdateUiState createState() => _AdminUpdateUiState();
}

class _AdminUpdateUiState extends State<AdminUpdateUi> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController admin_name =
      TextEditingController(text: admin_user_data["userName"]);
  TextEditingController admin_email =
      TextEditingController(text: admin_user_data["email"]);
  TextEditingController admin_password =
      TextEditingController(text: admin_user_data["password"]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "as Admin",
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: admin_name,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your name";
                              } else if (msg.length < 3) {
                                return "Name too short";
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.auto_fix_normal_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          // height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: admin_email,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your email";
                              } else if (!msg.contains("@")) {
                                return "Invalid email address";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: admin_password,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Please enter your password";
                              } else if (msg.length < 4) {
                                return "Password too weak";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            validator: (msg) {
                              if (msg != admin_password.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password_rounded,
                              ),
                              enabledBorder: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              String status = await update_admin(
                                  admin_user_data['u_id'].toString(),
                                  admin_name.text,
                                  admin_email.text,
                                  admin_password.text,
                                  context);
                              if (status == "Success") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Details Updated",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
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
                                "Update",
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
