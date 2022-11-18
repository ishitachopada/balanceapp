import 'dart:convert';
import 'dart:io';
import 'package:balanceapp/second.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'dash.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future get_data() async {
    //https://sidhdhi.000webhostapp.com/bank/select.php
    var url = Uri.parse('https://sidhdhi.000webhostapp.com/bank/select.php');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List m = jsonDecode(response.body);

    return m;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("myimage/puple.png"),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu_book,
                      size: 70,
                      color: Colors.white,
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Text(
                      "Account Manager",
                      style: TextStyle(color: Colors.white),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.deepPurple),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Credit(+)",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\u{20B9}0",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Debit(-)",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\u{20B9}0",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Balance",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "\u{20B9}0",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(Icons.home),
                title: Text("Home"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.backup_sharp),
                title: Text("Backup"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.restore),
                title: Text("Restore"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text("Change currency"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text("Change password"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.app_settings_alt_outlined),
                title: Text("Change security"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.share),
                title: Text("Share the app"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.star),
                title: Text("Rate the app"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.shield),
                title: Text("Privacy policy"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.apps),
                title: Text("More apps"),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.block),
                title: Text("Ads free"),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Save as PDF")),
              PopupMenuItem(child: Text("Save as Excel")),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: get_data(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List m = snapshot.data as List;
              return ListView.builder(
                itemCount: m.length,
                itemBuilder: (context, index) {
                  dash d = dash.fromJson(m[index]);
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return second(d);
                          },
                        ));
                      },
                      child: Container(
                        height: 130,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${d.name}",
                                  softWrap: true,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            t2.text = d.name!;
                                            showDialog(
                                                builder: (context) {
                                                  return AlertDialog(
                                                    titlePadding:
                                                        EdgeInsets.all(0),
                                                    // insetPadding: EdgeInsets.all(0),
                                                    actionsPadding:
                                                        EdgeInsets.all(10),
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    title: Container(
                                                      height: 45,
                                                      alignment:
                                                          Alignment.center,
                                                      color: Colors.deepPurple,
                                                      child:
                                                          Text("Edit account"),
                                                    ),
                                                    content: TextField(
                                                      controller: t2,
                                                    ),
                                                    actions: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 90,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .deepPurple),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .deepPurple),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          String name = t2.text;
                                                          //https://sidhdhi.000webhostapp.com/bank/update.php?name=rajesh&id=2
                                                          var url = Uri.parse(
                                                              'https://sidhdhi.000webhostapp.com/bank/update.php?name=$name&id=${d.id}');
                                                          var response =
                                                              await http
                                                                  .get(url);
                                                          print(
                                                              'Response status: ${response.statusCode}');
                                                          print(
                                                              'Response body: ${response.body}');
                                                          if (response.body ==
                                                              "data update") {
                                                            t2.text = "";
                                                            Navigator.pop(
                                                                context);
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                                return dashboard();
                                                              },
                                                            ));
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 90,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .deepPurple,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .deepPurple),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Text(
                                                            "Save",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                context: context);
                                          },
                                          icon: Icon(
                                            Icons.edit_note,
                                            color: Colors.deepPurple,
                                          )),
                                      IconButton(
                                          onPressed: () async {
                                            //https://sidhdhi.000webhostapp.com/bank/delete.php?id=1
                                            var url = Uri.parse(
                                                'https://sidhdhi.000webhostapp.com/bank/delete.php?id=${d.id}');
                                            var response = await http.get(url);
                                            print(
                                                'Response status: ${response.statusCode}');
                                            print(
                                                'Response body: ${response.body}');
                                            if (response.body ==
                                                "data deleted") {
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return dashboard();
                                                },
                                              ));
                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.deepPurple,
                                          )),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.grey),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RichText(
                                            softWrap: true,
                                            text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                      child: Icon(Icons
                                                          .upgrade_outlined)),
                                                  TextSpan(
                                                      text: ")",
                                                      style: TextStyle(
                                                          color: Colors.black))
                                                ],
                                                text: "Credit(",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          Text(
                                            "\u{20B9} 0",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.blueGrey),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RichText(
                                            softWrap: true,
                                            text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                      child: Icon(Icons
                                                          .vertical_align_bottom_outlined)),
                                                  TextSpan(
                                                      text: ")",
                                                      style: TextStyle(
                                                          color: Colors.black))
                                                ],
                                                text: "Debit(",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ),
                                          Text(
                                            "\u{20B9} 0",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.deepPurple),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text("Balance",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            "\u{20B9} 0",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("No data yet"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.deepOrange,
        child: Icon(
          Icons.add_to_photos_outlined,
        ),
        onPressed: () {
          showDialog(
              builder: (context) {
                return AlertDialog(
                  titlePadding: EdgeInsets.all(0),
                  // insetPadding: EdgeInsets.all(0),
                  actionsPadding: EdgeInsets.all(10),
                  contentPadding: EdgeInsets.all(10),
                  actionsAlignment: MainAxisAlignment.center,
                  title: Container(
                    height: 45,
                    alignment: Alignment.center,
                    color: Colors.deepPurple,
                    child: Text("Add new account"),
                  ),
                  content: TextField(
                    controller: t1,
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        String name = t1.text;
                        //https://sidhdhi.000webhostapp.com/bank/insert.php?name=sidhdhi
                        var url = Uri.parse(
                            'https://sidhdhi.000webhostapp.com/bank/insert.php?name=$name');
                        var response = await http.get(url);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        if (response.body == "data inserted") {
                          t1.text = "";
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return dashboard();
                            },
                          ));
                        }
                      },
                      child: Container(
                        height: 30,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
              context: context);
        },
      ),
    );
  }
}
