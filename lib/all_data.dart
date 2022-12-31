import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String user = "";

List<dynamic> data = [];
List<dynamic> teachers_data = [];
List<dynamic> subjects_data = [];
List<dynamic> subject_relation = [];
List<dynamic> notice = [];
List<String> days = ["Day1", "Day2", "Day3", "Day4", "Day5"];
List<String> timings = ["Slot1", "Slot2", "Slot3", "Slot4", "Slot5"];

Future<String> get_routine(BuildContext context, String who) async {
  try {
    Map mapeddata = {
      'action': 'get_all_routine',
      'id': who == "admin"
          ? admin_user_data['u_id']
          : teacher_user_data['admin_id']
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      print(" all is $data");

      // who == "admin"
      //     ? Provider.of<Shedule>(context).refresh_table()
      //     : print("hh");

      String days_data = data[1]["days"];
      String timings_data = data[1]["timings"];
      days = days_data.split(",");
      timings = timings_data.split(",");
      return "Success";
    } else {
      return "Failed";
    }
  } catch (e) {
    return "exception";
  }
}

Future<String> get_teachers() async {
  try {
    Map mapeddata = {
      'action': 'get_teachers',
      'admin_id': admin_user_data['u_id']
    };

    var response = await http.post(
      Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
      body: mapeddata,
    );

    if (response.statusCode == 200) {
      teachers_data = json.decode(response.body);
      print(" teachers is $teachers_data");
      return "Success";
    } else {
      return "Failed";
    }
  } catch (e) {
    return "exception";
  }
}

Future<String> get_subjects() async {
  try {
    Map mapeddata = {
      'action': 'get_subjects',
      'admin_id': admin_user_data['u_id']
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    if (response.statusCode == 200) {
      String status = await get_subjects_relation();

      if (status == "Success") {
        subjects_data = json.decode(response.body);
        print(" subjects is $subjects_data");
        return "Success";
      } else {
        return "Failed";
      }
    } else {
      return "Failed";
    }
  } catch (e) {
    return "exception";
  }
}

Future<String> get_subjects_relation() async {
  try {
    Map mapeddata = {
      'action': 'get_subjects_relation',
      'admin_id': admin_user_data['u_id']
    };

    var res = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    if (res.statusCode == 200) {
      subject_relation = json.decode(res.body);
      print(subject_relation);
      return "Success";
    } else {
      return "Failed";
    }
  } catch (e) {
    return "exception";
  }
}

Future<String> get_all_notice() async {
  try {
    Map mapeddata = {
      'action': 'get_notice',
      'id': user == "admin"
          ? admin_user_data['u_id']
          : teacher_user_data['admin_id']
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    if (response.statusCode == 200) {
      notice = json.decode(response.body);
      print(" all notice is $notice");

      return "Success";
    } else {
      return "Failed";
    }
  } catch (e) {
    return "exception";
  }
}

Map teacher_user_data = {
  'u_id': null,
  'userName': null,
  'code': null,
  'email': null,
  'password': null,
  'admin_id': null,
  'admin_name': null
};

Map admin_user_data = {
  'u_id': null,
  'userName': null,
  'email': null,
  'password': null
};
