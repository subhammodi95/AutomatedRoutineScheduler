// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './update_details.dart';
import './widgets/auth.dart';
import './all_data.dart';
import './widgets/register.dart';
import 'package:provider/provider.dart';

import 'notice_board.dart';

class TutorHomeUi extends StatefulWidget {
  @override
  State<TutorHomeUi> createState() => _TutorHomeUiState();
}

class _TutorHomeUiState extends State<TutorHomeUi> {
  List<Map> my_classes = [];
  void my_class() {
    for (var i = 0; i < data.length; i++) {
      for (var j = 1; j <= 5; j++) {
        if (splitting(data[i][j.toString()]) == teacher_user_data['code']) {
          Map m = {
            'subject': split(data[i][j.toString()]),
            'day': days[i],
            'time': timings[j - 1]
          };
          my_classes.add(m);
        }
      }
    }
  }

  //to separate teacher code from selected teachers
  String splitting(String str) {
    if (str.isEmpty) {
      return "";
    }
    final characters = Characters(str);
    str = characters.toList().reversed.join();
    str = str.substring(1, str.indexOf("("));
    final chars = Characters(str);
    str = chars.toList().reversed.join();
    return str;
  }

  //to remove the teacher code from subject received from the "all data" list
  String split(String str) {
    if (str == "") {
      return "";
    }
    final characters = Characters(str);
    str = characters.toList().reversed.join();
    str = str.substring(str.indexOf("(") + 1, str.length);
    final chars = Characters(str);
    str = chars.toList().reversed.join();
    return str;
  }

  Future<void> get_rout(BuildContext context) async {
    data.clear();
    String status = "";
    await get_routine(context, "teacher").then((value) => status = value);
    if (status == "Success") {
      my_class();
      setState(() {});
    } else if (status == "exception") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Please check your internet connection.",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      )));
    } else if (status == "Failed") {
      print("failed");
    }
  }

  @override
  void initState() {
    if (data.isEmpty) {
      get_rout(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context); //-------------------
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        //-------------------
        onRefresh: () => get_rout(context),
        child: Container(
          //-------------------
          margin: EdgeInsets.only(
              top: mediaquery.padding.top), //-------------------
          height: mediaquery.size.height -
              mediaquery.padding.top, //-------------------
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()), //-------------------
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome,",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Consumer<Update>(
                              builder: (ctx, auth, _) => FittedBox(
                                child: Text(
                                  "${teacher_user_data['userName']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "Your Admin's ID: ${teacher_user_data["admin_id"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Consumer<Update>(
                              builder: (ctx, auth, _) => FittedBox(
                                child: Text(
                                  "Admin Name: ${teacher_user_data['admin_name']}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                      builder: (context) => UpdateUi())),
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
                                await deleteaccount(teacher_user_data["u_id"],
                                    "teacher", context);
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
                      Column(children: [
                        MaterialButton(
                          onPressed: () async {
                            await Provider.of<Auth>(context, listen: false)
                                .logout();
                          },
                          color: Colors.red.shade100,
                          elevation: 0,
                          highlightElevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.19,
                            child: Center(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            height: MediaQuery.of(context).size.height * 0.05,
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
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
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
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
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
                          DataCell(Text(data[index]['1'])),
                          DataCell(Text(data[index]['2'])),
                          DataCell(Text(data[index]['3'])),
                          DataCell(Text(data[index]['4'])),
                          DataCell(Text(data[index]['5'])),
                        ]);
                      })),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                      text: "Your Classes",
                      style: TextStyle(
                        fontSize: 33,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
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
                            "Time",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Subject",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(my_classes.length, (index) {
                        return DataRow(cells: [
                          DataCell(Text(my_classes[index]['day'])),
                          DataCell(Text(my_classes[index]['time'])),
                          DataCell(Text(my_classes[index]['subject']))
                        ]);
                      })),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
