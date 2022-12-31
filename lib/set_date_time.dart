import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import 'widgets/scheduler.dart';

class set_date_time_page extends StatefulWidget {
  const set_date_time_page({Key? key}) : super(key: key);

  @override
  _set_date_time_pageState createState() => _set_date_time_pageState();
}

class _set_date_time_pageState extends State<set_date_time_page> {
  List<String> selected_days = [];
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController stime1 = TextEditingController();
  TextEditingController etime1 = TextEditingController();
  TextEditingController stime2 = TextEditingController();
  TextEditingController etime2 = TextEditingController();
  TextEditingController stime3 = TextEditingController();
  TextEditingController etime3 = TextEditingController();
  TextEditingController stime4 = TextEditingController();
  TextEditingController etime4 = TextEditingController();
  TextEditingController stime5 = TextEditingController();
  TextEditingController etime5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Set",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Date/Time",
                      style: TextStyle(
                        fontSize: 27,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropDownMultiSelect(
                    onChanged: (List<String> x) {
                      setState(() {
                        selected_days = x;
                      });
                    },
                    options: [
                      "Sunday",
                      "Monday",
                      "Tuesday",
                      "Wednesday",
                      "Thursday",
                      "Friday",
                      "Saturday"
                    ],
                    selectedValues: selected_days,
                    whenEmpty: "",
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      labelText: 'Select Days',
                      isDense: false,
                      labelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Set Time",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formkey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200,
                    ),
                    child: Column(
                      children: [
                        buildLabelText("1st Period"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: stime1,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Starts at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Seperator(),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: etime1,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Ends at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabelText("2nd Period"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: stime2,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Starts at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Seperator(),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: etime2,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Ends at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabelText("3rd Period"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: stime3,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Starts at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Seperator(),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: etime3,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Ends at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabelText("4th Period"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: stime4,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Starts at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Seperator(),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: etime4,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Ends at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabelText("5th Period"),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: stime5,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Starts at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Seperator(),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextFormField(
                                  controller: etime5,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: "Ends at",
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                  validator: (String? msg) {
                                    if (msg!.isEmpty) {
                                      return "Please enter starting time of first period";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (selected_days.length != 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Select 5 subjects",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else {
            String Days = selected_days.join(",");
            String Times = stime1.text +
                "-" +
                etime1.text +
                "," +
                stime2.text +
                "-" +
                etime2.text +
                "," +
                stime3.text +
                "-" +
                etime3.text +
                "," +
                stime4.text +
                "-" +
                etime4.text +
                "," +
                stime5.text +
                "-" +
                etime5.text;
            await Provider.of<Shedule>(context, listen: false)
                .update(Days, Times, context);
          }
        },
        elevation: 0,
        backgroundColor: Colors.red,
        label: Text(
          "Update",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Text buildLabelText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 22,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class Seperator extends StatelessWidget {
  const Seperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.red,
      ),
    );
  }
}
