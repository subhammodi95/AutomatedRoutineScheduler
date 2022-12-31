import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import './all_data.dart';
import './widgets/noticeRelated.dart';

class NoticeBoard extends StatefulWidget {
  NoticeBoard({Key? key}) : super(key: key);

  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  TextEditingController textmsg = TextEditingController();

  Future<void> getImage() async {
    try {
      final pickedfile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedfile != null) {
        Uint8List bytes = await pickedfile.readAsBytes();
        encode = base64Encode(bytes);
        image.isEmpty
            ? image.add(File(pickedfile.path))
            : image.insert(0, File(pickedfile.path));
        setState(() {});
      } else {
        print("No image selected");
      }
    } on PlatformException catch (e) {
      print("failed to pick image $e");
    }
  }

  Future<void> get_notice(BuildContext context) async {
    notice.clear();
    String status = "";
    await get_all_notice().then((value) => status = value);
    if (status == "Success") {
      setState(() {});
    }
    if (status == "exception") {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Some error occured. Please report",
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

  @override
  void initState() {
    if (notice.isEmpty) {
      get_notice(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  "Notice Board",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                user == "admin"
                    ? Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextFormField(
                                      controller: textmsg,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                        labelText: "Share with all teachers",
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: IconButton(
                                        onPressed: () async {
                                          await getImage();
                                        },
                                        icon: Icon(
                                          Icons.attachment,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      child: IconButton(
                                        onPressed: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          if (textmsg.text.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Please type something",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.redAccent,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Please Wait",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                backgroundColor: Colors.amber,
                                              ),
                                            );
                                            await send_notice(
                                                textmsg.text.trim(), context);
                                            image.clear();
                                            textmsg.clear();
                                            setState(() {});
                                          }
                                        },
                                        icon: Icon(
                                          Icons.send_rounded,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            image.isNotEmpty
                                ? Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        width: 150,
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.file(
                                            image[0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: IconButton(
                                          onPressed: () {
                                            image.clear();
                                            setState(() {});
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      )
                    : Container(),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      notice.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(top: 100),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.notifications_off_rounded,
                                      color: Colors.grey.shade400,
                                      size: 50,
                                    ),
                                    Text(
                                      "No notices posted yet",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 40,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Notices",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                      Column(
                        children: List.generate(notice.length, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${notice[index]['time']}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    user == "admin"
                                        ? GestureDetector(
                                            onTap: () async {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Please Wait",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.amber,
                                                ),
                                              );
                                              await delete_notice(
                                                  notice[index]['id'],
                                                  index,
                                                  context);
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    notice[index]['content'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                notice[index]['img'] != ""
                                    ? GestureDetector(
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              height: 300,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl: notice[index]
                                                      ['img'],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10, top: 3),
                                              child: IconButton(
                                                  onPressed: () {
                                                    download_img(
                                                        notice[index]['img'],
                                                        context);
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .file_download_outlined,
                                                    color: Colors.green,
                                                    size: 35,
                                                  )),
                                            )
                                          ],
                                        ),
                                        onTap: () {
                                          download_img(
                                              notice[index]['img'], context);
                                        })
                                    : Container()
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
