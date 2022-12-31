import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:tryy/widgets/add_subject.dart';
import 'all_data.dart';

class AddSubjectUi extends StatefulWidget {
  Function subject_field;
  AddSubjectUi(this.subject_field);
  @override
  _AddSubjectUiState createState() => _AddSubjectUiState(subject_field);
}

class _AddSubjectUiState extends State<AddSubjectUi> {
  Function subject_field;
  _AddSubjectUiState(this.subject_field);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController subject_name = TextEditingController();
  TextEditingController subject_code = TextEditingController();
  TextEditingController subject_credit = TextEditingController();
  TextEditingController subject_section = TextEditingController();

  List<String> _tutors = [];
  List<String> selected_teachers = [];

  Future<void> get_tutor() async {
    _tutors.clear();
    String status = "";
    await get_teachers().then((value) => status = value);
    if (status == "Success") {
      for (var i = 0; i < teachers_data.length; i++) {
        _tutors.add(
            teachers_data[i]["name"] + "(" + teachers_data[i]["code"] + ")");
      }
      setState(() {});
    } else if (status == "exception") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please check your internet connection.",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (status == "Failed") {
      print("tutor failed");
    }
  }

  @override
  void initState() {
    if (_tutors.isEmpty) {
      get_tutor();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Add\n",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      TextSpan(
                        text: "Subject",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formkey,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: subject_name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              labelText: "Subject name",
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Enter subject name";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: subject_code,
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              labelText: "Subject Code",
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Enter subject code";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: subject_credit,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              labelText: "Subject Credits",
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Enter Credits";
                              } else if (int.parse(msg) < 0) {
                                return "Enter subject credit greater than 0";
                              } else if (int.parse(msg) > 5) {
                                return "Subject Credits must be less than 5";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: subject_section,
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              labelText: "Subject Section",
                            ),
                            validator: (msg) {
                              if (msg!.isEmpty) {
                                return "Enter section";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropDownMultiSelect(
                            onChanged: (List<String> x) {
                              setState(() {
                                selected_teachers = x;
                              });
                            },
                            options: _tutors,
                            selectedValues: selected_teachers,
                            whenEmpty: "",
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              labelText: 'Teacher',
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        _tutors.isEmpty
                            ? Text(
                                '* There are currently no teachers to select',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : Container(),
                        SizedBox(height: 10),
                        MaterialButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              if (selected_teachers.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    "Please select atleast one teacher.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                var status = await add_subject(
                                    subject_name.text +
                                        "(" +
                                        subject_section.text +
                                        ")",
                                    subject_code.text,
                                    subject_credit.text,
                                    selected_teachers);
                                if (status.toString() == "-1") {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Please check your internet connection.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (status.toString() == "0") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Some error occurred",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  subject_name.clear();
                                  subject_code.clear();
                                  subject_credit.clear();
                                  selected_teachers.clear();
                                  subject_section.clear();
                                  subject_field();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Added successfully",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  subject_field();
                                }
                              }
                            }
                          },
                          color: Colors.red,
                          elevation: 0,
                          highlightColor: Colors.red.withOpacity(0.3),
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Add Subject",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
