// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './auth.dart';

String d = "";

Future<String> register_teacher(String teacherName, String teacherCode,
    String teacherEmail, String teacherPassword, String adminId) async {
  try {
    Map mapeddata = {
      'action': 'register_teacher',
      'name': teacherName,
      'code': teacherCode,
      'email': teacherEmail,
      'password': teacherPassword,
      'id': adminId
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    d = json.decode(response.body);

    return d;
  } catch (e) {
    return "Error Occurred";
  }
}

Future<String> register_admin(
    String Name, String Email, String Password) async {
  try {
    Map mapeddata = {
      'action': 'register_admin',
      'name': Name,
      'email': Email,
      'password': Password
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    d = json.decode(response.body);

    return d;
  } catch (e) {
    return "Error Occurred";
  }
}

void naviagateTutor(String email, String password, BuildContext ctx) async {
  Map _mapeddata = {
    'action': 'login_teacher',
    'email': email,
    'password': password
  };
  var APIURL =
      Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");

  FocusScope.of(ctx).requestFocus(
      FocusNode()); //to remove the keyboard automatically from floating over all the screens by changing the focus to null

  http.Response response = await http.post(APIURL, body: _mapeddata);

  var d = jsonDecode(response.body);
  if (d == "Wrong password" || d == "Invalid Credentials") {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(
        d,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    ));
  } else {
    Navigator.pop(ctx);
    await Provider.of<Auth>(ctx, listen: false).authenticate_teacher(d);
  }
}

void naviagateAdmin(String email, String password, BuildContext ctx) async {
  Map _mapeddata = {
    'action': 'login_admin',
    'email': email,
    'password': password
  };
  var APIURL =
      Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");

  FocusScope.of(ctx).requestFocus(
      FocusNode()); //to remove the keyboard automatically from floating over all the screens by changing the focus to null

  http.Response response = await http.post(APIURL, body: _mapeddata);

  var d = jsonDecode(response.body);
  if (d == "Wrong password" || d == "Invalid Credentials") {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(
        d,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.red,
    ));
  } else {
    Navigator.pop(ctx);
    await Provider.of<Auth>(ctx, listen: false).authenticate_admin(d);
  }
}

Future<void> deleteaccount(var id, var who, BuildContext context) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: const Text('Are you sure?'),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Yes',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          onPressed: () async {
            Navigator.of(ctx).pop();
            int status = await _deleteaccount(id, who);
            if (status == 1) {
              await Provider.of<Auth>(context, listen: false).logout();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Account deleted",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.green,
              ));
            } else if (status == 0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Account deletion failed",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ));
            } else if (status == -1) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Please check your internet connection",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
        ),
        TextButton(
          child: const Text(
            'No',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          onPressed: () {
            Navigator.of(ctx).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Account deletion failed",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ));
          },
        )
      ],
    ),
  );
}

Future<int> _deleteaccount(var id, var who) async {
  try {
    Map mapeddata = {
      'action': who == "admin" ? "delete_admin" : "delete_teacher",
      'id': id
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    int data = int.parse(json.decode(response.body));
    return data;
  } catch (e) {
    return -1;
  }
}

Future<String> update_admin(String id, String Name, String Email,
    String Password, BuildContext ctx) async {
  try {
    Map mapeddata = {
      'action': 'update_admin',
      'id': id,
      'name': Name,
      'email': Email,
      'password': Password
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    d = json.decode(response.body);
    if (d.toString() == "Success") {
      await Provider.of<Update>(ctx, listen: false)
          .update_pref_admin(mapeddata);
    }

    return d.toString();
  } catch (e) {
    return "Please check your internet connection";
  }
}

Future<String> update_teacher(
    String id,
    String teacherName,
    String teacherCode,
    String teacherEmail,
    String teacherPassword,
    String adminId,
    BuildContext ctx) async {
  try {
    Map mapeddata = {
      'action': 'update_teacher',
      'id': id,
      'name': teacherName,
      'code': teacherCode,
      'email': teacherEmail,
      'password': teacherPassword,
      'ad_id': adminId,
      'ad_name': ""
    };

    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    d = json.decode(response.body);
    if (d.toString().substring(0, 7) == "Success") {
      mapeddata['ad_name'] = d.toString().substring(7, d.toString().length);
      await Provider.of<Update>(ctx, listen: false)
          .update_pref_teacher(mapeddata);
      return d.toString().substring(0, 7);
    } else {
      return d.toString();
    }
  } catch (e) {
    return "Please check your internet connection";
  }
}
