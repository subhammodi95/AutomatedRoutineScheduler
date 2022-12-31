import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'all_data.dart';

class AddedSubjectsUi extends StatefulWidget {
  Function subject_field;
  AddedSubjectsUi(this.subject_field);

  @override
  _AddedSubjectsUiState createState() => _AddedSubjectsUiState(subject_field);
}

class _AddedSubjectsUiState extends State<AddedSubjectsUi> {
  Function subject_field;
  _AddedSubjectsUiState(this.subject_field);

  String this_subject_teachers(var id) {
    List subject_teachers_name = [];
    for (int i = 0; i < subject_relation.length; i++) {
      if (int.parse(subject_relation[i]["subject_id"]) == int.parse(id)) {
        if (!subject_teachers_name.contains(subject_relation[i]["name"])) {
          subject_teachers_name.add(subject_relation[i]["name"]);
        }
      }
    }
    return subject_teachers_name.join(',');
  }

  Future<void> _deletesubject(id, index, data) async {
    var APIURL =
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");
    Map mapeddata = {
      'action': 'delete_subject',
      'id': id,
    };

    http.Response response = await http.post(APIURL, body: mapeddata);

    var d = jsonDecode(response.body).toString();
    if (d == "1") {
      data.removeAt(index);
      subject_field();
      setState(() {});
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Subject Deleted",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Oops!! Some error occurred",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showTopFlash(id, index, data) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Are you sure?'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Yes',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Please Wait",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.amber,
                ),
              );
              Navigator.of(ctx).pop();
              await _deletesubject(id, index, data);
            },
          ),
          TextButton(
            child: Text(
              'No',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "All\n",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    TextSpan(
                      text: "Subjects",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subjects_data.isNotEmpty
                          ? Column(
                              children: [
                                Column(
                                  children: List.generate(
                                    subjects_data.length,
                                    (index) {
                                      return subjectTile(
                                        index,
                                        subjects_data[index]["s_name"],
                                        subjects_data[index]['s_code'],
                                        subjects_data[index]['credits'],
                                        this_subject_teachers(
                                            subjects_data[index]['subject_id']),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 90),
                              child: Text(
                                'No subjects added yet',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
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
    );
  }

  Widget subjectTile(
    int index,
    String sname,
    String scode,
    String scredit,
    String steacher,
  ) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: size.height * 0.08,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: sname,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: size.height * 0.03,
                          color: Colors.red.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showTopFlash(subjects_data[index]['subject_id'], index,
                        subjects_data);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            // height: size.height * 0.1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.16),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Subject Code: ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: scode,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "\nCredits: ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: scredit,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: "\nTeachers: ",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: steacher,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
