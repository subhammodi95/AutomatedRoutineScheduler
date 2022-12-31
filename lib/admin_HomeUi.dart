// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flip_card/flip_card.dart';
import 'package:tryy/addSubjectUi.dart';
import 'package:tryy/addedSubjectsUi.dart';
import 'package:tryy/set_date_time.dart';
import './update_details.dart';

import './all_data.dart';
import 'package:select_form_field/select_form_field.dart';
import './widgets/auth.dart';
import './widgets/scheduler.dart';
import './widgets/register.dart';
import 'package:provider/provider.dart';

import 'notice_board.dart';

class Admin_HomeUi extends StatefulWidget {
  @override
  _Admin_HomeUiState createState() => _Admin_HomeUiState();
}

class _Admin_HomeUiState extends State<Admin_HomeUi> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController subject_name = TextEditingController();
  TextEditingController subject_code = TextEditingController();
  TextEditingController subject_credit = TextEditingController();
  TextEditingController subject_section = TextEditingController();

  TextEditingController selected_subject = TextEditingController();

  List<String> selected_teachers = [];
  List<Map<String, dynamic>> subjects = [];

  Future<void> get_rout(BuildContext context) async {
    data.clear();
    selected_subject.clear();
    String status = "";
    await get_routine(context, "admin").then((value) => status = value);
    if (status == "Success") {
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
    } else if (status == "Failed") {}
  }

  Future<void> get_sub() async {
    String status = "";
    await get_subjects().then((value) => status = value);
    if (status == "Success") {
      subject_field();
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
    } else if (status == "Failed") {}
  }

  void subject_field() {
    subjects = [
      for (var i = 0; i < subjects_data.length; i++)
        {
          'value': subjects_data[i]['subject_id'],
          'label': subjects_data[i]['s_name'].toString() +
              " (" +
              subjects_data[i]['s_code'].toString() +
              ")"
        },
    ];
    setState(() {});
  }

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

  Future<void> refresh(BuildContext context) async {
    data.clear();
    teachers_data.clear();
    subjects_data.clear();
    await get_rout(context);
    await get_sub();
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (data.isEmpty) {
      get_rout(context);
    }
    if (subjects_data.isEmpty) {
      get_sub();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => refresh(context),
        child: Container(
          margin: EdgeInsets.only(
              top: mediaquery.padding.top), //-------------------
          height: mediaquery.size.height -
              mediaquery.padding.top, //-------------------
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),

                  //=================== assign dates ===================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome,",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Consumer<Update>(
                              builder: (ctx, auth, _) => FittedBox(
                                child: Text(
                                  admin_user_data['userName'],
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "ID: " + admin_user_data['u_id'],
                                style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminUpdateUi())),
                              color: Colors.red,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.edit_attributes,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Update Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                await deleteaccount(
                                    admin_user_data["u_id"], "admin", context);
                              },
                              color: Colors.red,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Delete Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              await Provider.of<Auth>(context, listen: false)
                                  .logout();
                            },
                            color: Colors.red.shade100,
                            elevation: 0,
                            highlightElevation: 0,
                            highlightColor: Colors.red.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: Center(
                                child: Text(
                                  "Logout",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoticeBoard()));
                            },
                            color: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              height:
                                  MediaQuery.of(context).size.height * 0.115,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.notifications_none,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Notice Board",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddSubjectUi(subject_field)));
                        },
                        color: Colors.red.shade100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          height: 90,
                          width: 70,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                'Add\nSubject',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            )),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    textLabel(
                                      text: "Asign Dates",
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 8),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: SelectFormField(
                                              controller: selected_subject,
                                              items: subjects,
                                              type: SelectFormFieldType.dialog,
                                              dialogTitle: 'Select a subject',
                                              dialogCancelBtn: 'Cancel',
                                              enableSearch: true,
                                              dialogSearchHint:
                                                  'Search for subject',
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText: 'Subject',
                                                labelStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                icon: Icon(
                                                    Icons.date_range_sharp),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              subject = selected_subject.text;
                                              if (subject.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Please select a Subject",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } else {
                                                Provider.of<Shedule>(context,
                                                        listen: false)
                                                    .initialize_cells();
                                                Provider.of<Shedule>(context,
                                                        listen: false)
                                                    .count();
                                                Provider.of<Shedule>(context,
                                                        listen: false)
                                                    .avl();
                                                await Provider.of<Shedule>(
                                                        context,
                                                        listen: false)
                                                    .get_slot(context);
                                              }
                                            },
                                            color: Colors.red,
                                            elevation: 0,
                                            highlightColor:
                                                Colors.red.withOpacity(0.3),
                                            highlightElevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              width: double.infinity,
                                              child: Center(
                                                child: Text(
                                                  "Assign Dates",
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
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        color: Colors.red.shade100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          height: 90,
                          width: 70,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                'Assign\nDates',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddedSubjectsUi(subject_field)));
                        },
                        color: Colors.red.shade100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          height: 90,
                          // width: 70,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Icon(
                                Icons.subject,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(
                                'All\nSubjects',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Routine\n",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              TextSpan(
                                text: "DashBoard",
                                style: TextStyle(
                                  fontSize: 33,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        set_date_time_page()));
                          },
                          tooltip: "Set Date/Time",
                          icon: Icon(
                            Icons.settings_applications_rounded,
                            color: Colors.red,
                            size: 35,
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Consumer<Shedule>(
                      builder: (context, shed, _) => DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Day',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                timings[0],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                timings[1],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                timings[2],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                timings[3],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                timings[4],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(data.length, (index) {
                            return DataRow(cells: [
                              DataCell(Text(days[index])),
                              DataCell(Text(data[index]['1']), onTap: () async {
                                await Provider.of<Shedule>(context,
                                        listen: false)
                                    .edit_cell(
                                        context, index, "1", data[index]['1']);
                              }),
                              DataCell(Text(data[index]['2']), onTap: () async {
                                await Provider.of<Shedule>(context,
                                        listen: false)
                                    .edit_cell(
                                        context, index, "2", data[index]['2']);
                              }),
                              DataCell(Text(data[index]['3']), onTap: () async {
                                await Provider.of<Shedule>(context,
                                        listen: false)
                                    .edit_cell(
                                        context, index, "3", data[index]['3']);
                              }),
                              DataCell(Text(data[index]['4']), onTap: () async {
                                await Provider.of<Shedule>(context,
                                        listen: false)
                                    .edit_cell(
                                        context, index, "4", data[index]['4']);
                              }),
                              DataCell(Text(data[index]['5']), onTap: () async {
                                await Provider.of<Shedule>(context,
                                        listen: false)
                                    .edit_cell(
                                        context, index, "5", data[index]['5']);
                              }),
                            ]);
                          })),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Provider.of<Shedule>(context, listen: false)
              .save(data, context);
        },
        elevation: 0,
        backgroundColor: Colors.red,
        label: Text(
          "Save",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        icon: Icon(Icons.save),
      ),
    );
  }

  Text textLabel({required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}
