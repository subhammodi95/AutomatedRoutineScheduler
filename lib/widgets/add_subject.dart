import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../all_data.dart';

Future<String> add_subject(String subject_name, String subject_code,
    String subject_credit, List<String> selected_teachers) async {
  List<String> teachers = [];
  try {
    var APIURL =
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");

    //to separate teacher code from selected teachers
    String splitting(String str) {
      final characters = Characters(str);
      str = characters.toList().reversed.join();
      str = str.substring(1, str.indexOf("("));
      final chars = Characters(str);
      str = chars.toList().reversed.join();
      return str;
    }

    //get teacher id
    for (int i = 0; i < selected_teachers.length; i++) {
      for (int j = 0; j < teachers_data.length; j++) {
        if (teachers_data[j]["code"] == splitting(selected_teachers[i])) {
          teachers.add(teachers_data[j]["id"]);
        }
      }
    }

    Map mapeddata = {
      'action': 'add_subject',
      'name': subject_name.toString(),
      'code': subject_code.toString(),
      'credit': subject_credit.toString(),
      'teacher_id': jsonEncode(teachers),
      'admin_id': admin_user_data['u_id']
    };

    http.Response response = await http.post(APIURL, body: mapeddata);

    var d = jsonDecode(response.body);
    Map<String, String> addeddata;

    if (d > 0) {
      addeddata = {
        'subject_id': d.toString(),
        's_name': subject_name,
        's_code': subject_code,
        'credits': subject_credit,
      };
      subjects_data.add(addeddata);
      //to refresh the subject_relation array
      await get_subjects_relation();

      return d.toString();
    } else {
      return "0";
    }
  } catch (e) {
    return "-1";
  }
}
