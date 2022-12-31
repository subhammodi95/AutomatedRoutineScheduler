import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryy/widgets/noticeRelated.dart';

import '../all_data.dart';

class Auth with ChangeNotifier {
  bool authenticated = false;

  bool get isAuth {
    return authenticated != false;
  }

  Future<void> logout() async {
    authenticated = false;
    user = "";
    data.clear();
    teachers_data.clear();
    subjects_data.clear();
    teacher_user_data = {};
    admin_user_data = {};
    notice.clear();
    image.clear();
    encode = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData') ?? "") as Map<String, dynamic>;
    print("from preff $extractedUserData");
    user = extractedUserData['user'].toString();
    if (user == "teacher") {
      teacher_user_data['u_id'] = extractedUserData['u_id'];
      teacher_user_data['code'] = extractedUserData['code'];
      teacher_user_data['userName'] = extractedUserData['userName'];
      teacher_user_data['email'] = extractedUserData['email'];
      teacher_user_data['password'] = extractedUserData['password'];
      teacher_user_data['admin_id'] = extractedUserData['admin_id'];
      teacher_user_data['admin_name'] = extractedUserData['admin_name'];
    } else if (user == "admin") {
      admin_user_data['u_id'] = extractedUserData['u_id'];
      admin_user_data['userName'] = extractedUserData['userName'];
      admin_user_data['email'] = extractedUserData['email'];
      admin_user_data['password'] = extractedUserData['password'];
    }

    authenticated = true;
    notifyListeners();

    return true;
    // teacher_user_data['admin_name'] = extractedUserData['ad_name'];
  }

  Future<void> authenticate_teacher(Map d) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'user': "teacher",
        'u_id': d['id'],
        'userName': d['name'],
        'code': d['code'],
        'email': d['email'],
        'password': d['password'],
        'admin_id': d['admin_id'],
        'admin_name': d['ad_name']
      },
    );
    prefs.setString('userData', userData);
    user = "teacher";
    teacher_user_data['u_id'] = d['id'];
    teacher_user_data['userName'] = d['name'];
    teacher_user_data['code'] = d['code'];
    teacher_user_data['email'] = d['email'];
    teacher_user_data['admin_id'] = d['admin_id'];
    teacher_user_data['admin_name'] = d['ad_name'];
    teacher_user_data['password'] = d['password'];
    authenticated = true;
    notifyListeners();
  }

  Future<void> authenticate_admin(Map d) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'user': "admin",
        'u_id': d['admin_id'],
        'userName': d['ad_name'],
        'email': d['Email'],
        'password': d['password']
      },
    );
    print("authh $userData");
    prefs.setString('userData', userData);
    user = "admin";
    admin_user_data['u_id'] = d['admin_id'];
    admin_user_data['userName'] = d['ad_name'];
    admin_user_data['email'] = d['Email'];
    admin_user_data['password'] = d['password'];

    authenticated = true;
    notifyListeners();
  }
}

class Update with ChangeNotifier {
  Future<void> update_pref_admin(Map d) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    final userData = json.encode(
      {
        'user': "admin",
        'u_id': d['id'],
        'userName': d['name'],
        'email': d['email'],
        'password': d['password']
      },
    );
    print("authh $userData");
    prefs.setString('userData', userData);
    user = "admin";
    admin_user_data['u_id'] = d['id'];
    admin_user_data['userName'] = d['name'];
    admin_user_data['email'] = d['email'];
    admin_user_data['password'] = d['password'];
    notifyListeners();
  }

  Future<void> update_pref_teacher(Map d) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    final userData = json.encode(
      {
        'user': "teacher",
        'u_id': d['id'],
        'userName': d['name'],
        'code': d['code'],
        'email': d['email'],
        'password': d['password'],
        'admin_id': d['ad_id'],
        'admin_name': d['ad_name']
      },
    );
    print("authh $userData");
    prefs.setString('userData', userData);
    user = "teacher";
    teacher_user_data['u_id'] = d['id'];
    teacher_user_data['userName'] = d['name'];
    teacher_user_data['code'] = d['code'];
    teacher_user_data['email'] = d['email'];
    teacher_user_data['password'] = d['password'];
    teacher_user_data['admin_id'] = d['ad_id'];
    teacher_user_data['admin_name'] = d['ad_name'];
    notifyListeners();
  }
}
