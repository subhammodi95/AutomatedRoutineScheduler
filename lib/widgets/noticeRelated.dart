import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dio/dio.dart';

import 'package:jiffy/jiffy.dart';

import '../all_data.dart';

List<File> image = [];
String encode = "";

Future<void> send_notice(String msg, BuildContext context) async {
  try {
    Map mapeddata = {
      'action': 'send_notice',
      'msg': msg,
      'img': encode,
      'time': Jiffy(DateTime.now()).format('do MMM yyyy, h:mm:ss a'),
      'id': admin_user_data['u_id']
    };
    var response = await http.post(
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php"),
        body: mapeddata);

    if (response.statusCode == 200) {
      Map addeddata = {
        'id': jsonDecode(response.body).toString(),
        'admin_id': admin_user_data['u_id'],
        'content': msg,
        'img': encode != ""
            ? "https://subhammodi.000webhostapp.com/images/${admin_user_data['u_id']}.${jsonDecode(response.body).toString()}.jpg"
            : "",
        'time': Jiffy(DateTime.now()).format('do MMM yyyy, h:mm:ss a'),
      };
      notice.insert(0, addeddata);
      encode = '';
      image.clear();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Success!! Notice Posted",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Some error occured",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ));
    }
  } catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Please check your internet connection",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
}

Future<void> delete_notice(id, index, BuildContext context) async {
  try {
    var APIURL =
        Uri.parse("https://subhammodi.000webhostapp.com/schedule_pages.php");
    Map mapeddata = {
      'action': 'delete_notice',
      'id': id,
      'admin_id': admin_user_data['u_id']
    };

    http.Response response = await http.post(APIURL, body: mapeddata);

    var d = jsonDecode(response.body).toString();
    if (d.toString() == "1") {
      notice.removeAt(index);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Notice Deleted",
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
  } catch (e) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
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

void download_img(String url, BuildContext context) async {
  try {
    Directory directory;
    if (await _requestpermission(Permission.storage)) {
      directory = (await getExternalStorageDirectory())!;
      //till now we have got the basic default address storage that is at /storage/emulated/0/Android/data/..........
      String newpath = "";
      List<String> folders =
          directory.path.split("/"); //to reach the Android folder
      for (int x = 1; x < folders.length; x++) {
        //x=1 because at x=0 is empty
        String folder = folders[x];
        if (folder != "Android") {
          newpath += "/" + folder;
        } else {
          break;
        }
      }
      newpath = newpath + "/Automated Routine Scheduler";
      directory = Directory(newpath);

      if (!await directory.exists()) {
        //if directory extracted does not exists, create one
        await directory.create(recursive: true);
      }

      final file = File("${directory.path}/${url.substring(43)}");

      var response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Success!! Saved to documents/Automated Routine Scheduler",
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
            "Failed!! Storage Access Denied",
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
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Failed!! Please check your internet connection",
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

Future<bool> _requestpermission(Permission permission) async {
  //to check if user accepted the permissions
  if (await permission.isGranted) {
    return true;
  } else {
    var result =
        await permission.request(); //request permission again to the user
    if (result == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
