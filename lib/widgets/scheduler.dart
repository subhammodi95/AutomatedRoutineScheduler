// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../all_data.dart';

String subject = "";
String seat = "0";

class Shedule with ChangeNotifier {
  List count_arr = [];
  List cells = [];
  List available_teachers = [];

  void refresh_table() {
    notifyListeners();
  }

  void initialize_cells() {
    for (int i = 0; i < 27; i++) {
      cells.add("");
    }
    print(cells);
    print(cells.length);
  }

  void count() {
    available_teachers.clear();
    count_arr.clear();
    // for getting all teachers assigned for that particular subject
    for (int i = 0; i < subject_relation.length; i++) {
      if (int.parse(subject_relation[i]["subject_id"]) == int.parse(subject)) {
        if (!available_teachers.contains(subject_relation[i]["name"])) {
          available_teachers.add(subject_relation[i]["code"]);
        }
      }
    }

    // for accessing the credits and name of that subject from database
    for (int i = 0; i < subjects_data.length; i++) {
      if (int.parse(subjects_data[i]["subject_id"]) == int.parse(subject)) {
        seat = subjects_data[i]["credits"].toString();
        subject = subjects_data[i]["s_name"];
        break;
      }
    }

    for (int i = 0; i < data.length; i++) {
      // iterating over days
      int count = 0;
      for (int j = 1; j <= 5; j++) {
        // iterating over time
        if (splitting(data[i][j.toString()]) == subject) {
          count++;
        }
      }
      count_arr.add([data[i]['id'], count]);
    }
    print("count array is : $count_arr");
  }

  //to remove the teacher code from subject received from the "all data" list
  String splitting(String str) {
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

  void avl() {
    for (int i = 0; i < 5; i++) {
      for (int j = 1; j <= 5; j++) {
        if (data[i][j.toString()] == "") {
          var n = get_cell_id(i + 1, j);
          cells[n] = 0;
        } else if (splitting(data[i][j.toString()]) == subject) {
          var n = get_cell_id(i + 1, j);
          cells[n] = 1;
        }
      }
    }
    print('updated cells is $cells');
  }

  int get_cell_id(int d, int t) {
    int r = 0;
    if (d == 1 && t == 1) {
      r = 1;
    } else if (d == 1 && t == 2) {
      r = 2;
    } else if (d == 1 && t == 3) {
      r = 3;
    } else if (d == 1 && t == 4) {
      r = 4;
    } else if (d == 1 && t == 5) {
      r = 5;
    } else if (d == 2 && t == 1) {
      r = 6;
    } else if (d == 2 && t == 2) {
      r = 7;
    } else if (d == 2 && t == 3) {
      r = 8;
    } else if (d == 2 && t == 4) {
      r = 9;
    } else if (d == 2 && t == 5) {
      r = 10;
    } else if (d == 3 && t == 1) {
      r = 11;
    } else if (d == 3 && t == 2) {
      r = 12;
    } else if (d == 3 && t == 3) {
      r = 13;
    } else if (d == 3 && t == 4) {
      r = 14;
    } else if (d == 3 && t == 5) {
      r = 15;
    } else if (d == 4 && t == 1) {
      r = 16;
    } else if (d == 4 && t == 2) {
      r = 17;
    } else if (d == 4 && t == 3) {
      r = 18;
    } else if (d == 4 && t == 4) {
      r = 19;
    } else if (d == 4 && t == 5) {
      r = 20;
    } else if (d == 5 && t == 1) {
      r = 21;
    } else if (d == 5 && t == 2) {
      r = 22;
    } else if (d == 5 && t == 3) {
      r = 23;
    } else if (d == 5 && t == 4) {
      r = 24;
    } else if (d == 5 && t == 5) {
      r = 25;
    }
    return r;
  }

  List get_day_time(int index) {
    List m = [];
    if (index == 1) {
      m = [1, 1];
    } else if (index == 2) {
      m = [1, 2];
    } else if (index == 3) {
      m = [1, 3];
    } else if (index == 4) {
      m = [1, 4];
    } else if (index == 5) {
      m = [1, 5];
    } else if (index == 6) {
      m = [2, 1];
    } else if (index == 7) {
      m = [2, 2];
    } else if (index == 8) {
      m = [2, 3];
    } else if (index == 9) {
      m = [2, 4];
    } else if (index == 10) {
      m = [2, 5];
    } else if (index == 11) {
      m = [3, 1];
    } else if (index == 12) {
      m = [3, 2];
    } else if (index == 13) {
      m = [3, 3];
    } else if (index == 14) {
      m = [3, 4];
    } else if (index == 15) {
      m = [3, 5];
    } else if (index == 16) {
      m = [4, 1];
    } else if (index == 17) {
      m = [4, 2];
    } else if (index == 18) {
      m = [4, 3];
    } else if (index == 19) {
      m = [4, 4];
    } else if (index == 20) {
      m = [4, 5];
    } else if (index == 21) {
      m = [5, 1];
    } else if (index == 22) {
      m = [5, 2];
    } else if (index == 23) {
      m = [5, 3];
    } else if (index == 24) {
      m = [5, 4];
    } else if (index == 25) {
      m = [5, 5];
    }
    return m;
  }

  Future<void> get_slot(BuildContext context) async {
    int k = 0;
    List resultSlots = [];
    for (int i = 1; i <= int.parse(seat); i++) {
      for (int j = 1; j <= 25; j++) {
        if (cells[j] == 0) {
          List m = get_day_time(j);
          if (count_arr[m[0] - 1][1] + 1 == 1) {
            if (cells[j - 1] != 1 && cells[j + 1] != 1) {
              resultSlots.add(m);
              data[m[0] - 1][m[1].toString()] =
                  subject + "(" + available_teachers[k] + ")";
              cells[j] = 1;
              count_arr[m[0] - 1][1] = count_arr[m[0] - 1][1] + 1;
              //
              k = k + 1;
              if (k == available_teachers.length) {
                k = 0;
              }
              break;
            }
          }
        }
      }
    }
    print(resultSlots);

    count_arr.clear();
    cells.clear();
    initialize_cells();
    available_teachers.clear();
    if (resultSlots.length == int.parse(seat)) {
      _showErrorDialog(context, "Allotted all ${resultSlots.length} slots.");
      notifyListeners();
    } else if (resultSlots.isEmpty) {
      _showErrorDialog(context, " 0 slots available");
    } else {
      _showErrorDialog(
          context, "Sorry allotted only ${resultSlots.length} slots.");
      notifyListeners();
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('Alert'),
        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Okay',
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

  //-------------------------------------------

  Future<void> save(List data, BuildContext context) async {
    // print("objectt $data");
    try {
      var APIURL =
          Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");

      var json_data = jsonEncode(data);

      Map mapeddata = {
        'action': 'save_routine',
        'id': admin_user_data['u_id'],
        'data': json_data
      };
      http.Response response = await http.post(APIURL, body: mapeddata);
      var d = jsonDecode(response.body);
      if (d.toString() == '1') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Routine Saved",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Saving unsuccessful",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please check your internet connection",
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

  //===================================
  Future<void> update(String Days, String Times, BuildContext context) async {
    try {
      var APIURL =
          Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");

      Map mapeddata = {
        'action': 'update_day_time',
        'id': admin_user_data['u_id'],
        'day': Days,
        'time': Times
      };
      http.Response response = await http.post(APIURL, body: mapeddata);
      var d = jsonDecode(response.body);
      if (d.toString() == 'Success') {
        days = Days.split(",");
        timings = Times.split(",");

        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Updated successfully",
              style: TextStyle(
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
              "Failed",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please check your internet connection",
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

  //---------------------------
  Future<void> edit_cell(
      BuildContext context, int index, String i, String name) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Alert'),
        content:
            Text("Don't forget to save finally to make changes permanently."),
        actions: <Widget>[
          TextButton(
            child: const Text('Clear only this cell'),
            onPressed: () async {
              Navigator.of(ctx).pop();
              if (name == "") {
                _showErrorDialog(context, " Empty cell ");
              } else {
                int status = await clear_this_cell(index, i);
                status == 1
                    ? _showErrorDialog(context, " Routine updated ")
                    : _showErrorDialog(context, " OOPS! Error Found ");
              }
            },
          ),
          TextButton(
            child: const Text('Clear all cells with this subject'),
            onPressed: () async {
              Navigator.of(ctx).pop();
              if (name == "") {
                _showErrorDialog(context, " Empty cell ");
              } else {
                int status = await clear_all_cells(name);
                status == 1
                    ? _showErrorDialog(context, " Routine updated ")
                    : _showErrorDialog(context, " OOPS! Error Found ");
              }
            },
          )
        ],
      ),
    );
  }

  Future<int> clear_this_cell(int index, String i) async {
    data[index][i] = "";
    notifyListeners();
    return 1;
  }

  Future<int> clear_all_cells(String name) async {
    for (int i = 0; i < data.length; i++) {
      for (int j = 1; j <= 5; j++) {
        if (data[i][j.toString()] == name) {
          data[i][j.toString()] = "";
        }
      }
    }
    notifyListeners();
    return 1;
  }
}
