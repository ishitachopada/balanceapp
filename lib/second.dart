import 'dart:convert';
import 'package:balanceapp/transact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dash.dart';

class second extends StatefulWidget {
  dash d;

  second(this.d);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  String grp = "credit";
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  int deb = 0;
  int cre = 0;
  int bal = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calc();
  }

  Future get_data() async {
    //https://sidhdhi.000webhostapp.com/bank/selecttran.php?userid=4
    var url = Uri.parse(
        'https://sidhdhi.000webhostapp.com/bank/selecttran.php?userid=${widget.d.id}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body11111: ${response.body}');
    List m = jsonDecode(response.body);
    if (m.length == 0) {
      return null;
    } else {
      return m;
    }
  }

  calc() async {
    var url = Uri.parse(
        'https://sidhdhi.000webhostapp.com/bank/selecttran.php?userid=${widget.d.id}');
    var response = await http.get(url);
    List m = jsonDecode(response.body);
    m.forEach((element) {
      transact s = transact.fromJson(element);
      if (s.type == "credit") {
        cre = cre + int.parse(s.amount!);
      } else {
        deb = deb + int.parse(s.amount!);
      }
    });
    bal = cre - deb;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("${widget.d.name}"),
        actions: [
          IconButton(
              onPressed: () {
                dialog();
              },
              icon: Icon(Icons.add_box)),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Save as PDF")),
              PopupMenuItem(child: Text("Save as Excel")),
              PopupMenuItem(child: Text("Save as app")),
              PopupMenuItem(child: Text("Rate the app")),
              PopupMenuItem(child: Text("More apps")),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 35,
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "Date",
                  textAlign: TextAlign.center,
                )),
                Expanded(
                    child: Text(
                  "Particular",
                  textAlign: TextAlign.center,
                )),
                Expanded(
                    child: Text(
                  "Credit(\u{20B9})",
                  textAlign: TextAlign.end,
                )),
                Expanded(
                    child: Text(
                  "Debit(\u{20B9})",
                  textAlign: TextAlign.end,
                )),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: get_data(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List m = snapshot.data as List;
                    return ListView.builder(
                      itemCount: m.length,
                      itemBuilder: (context, index) {
                        transact t = transact.fromJson(m[index]);
                        return InkWell(
                          onTap: () {
                            showDialog(
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("EDIT or DELETE"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            grp = t.type!;
                                            t1.text = t.date!;
                                            t2.text = t.amount!;
                                            t3.text = t.reason!;
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  // scrollable: false,
                                                  actionsAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  // actionsOverflowDirection: VerticalDirection.up,
                                                  // contentPadding: EdgeInsets.all(10),
                                                  titlePadding:
                                                      EdgeInsets.all(0),
                                                  title: Container(
                                                    height: 40,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.deepPurple),
                                                    child: Text(
                                                      "Add transaction",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Transaction Date",
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            )),
                                                        TextField(
                                                          controller: t1,
                                                          keyboardType:
                                                              TextInputType
                                                                  .datetime,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Date"),
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child:
                                                              StatefulBuilder(
                                                            builder: (context,
                                                                setState1) {
                                                              return Row(
                                                                children: [
                                                                  Text(
                                                                    "Transaction type : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Radio(
                                                                    value:
                                                                        "credit",
                                                                    groupValue:
                                                                        grp,
                                                                    onChanged: <
                                                                        String>(value) {
                                                                      grp =
                                                                          value;
                                                                      setState1(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                  Text(
                                                                      "Credit(+)"),
                                                                  Radio(
                                                                    value:
                                                                        "debit",
                                                                    groupValue:
                                                                        grp,
                                                                    onChanged: <
                                                                        String>(value) {
                                                                      grp =
                                                                          value;
                                                                      setState1(
                                                                          () {});
                                                                    },
                                                                  ),
                                                                  Text(
                                                                      "Debit(-)"),
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        TextField(
                                                          controller: t2,
                                                          keyboardType:
                                                              TextInputType
                                                                  .numberWithOptions(),
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Amount"),
                                                        ),
                                                        TextField(
                                                          controller: t3,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Particular"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 100,
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
                                                          "CANCEL",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        String date = t1.text;
                                                        String type = grp;
                                                        String amt = t2.text;
                                                        String res = t3.text;
                                                        //https://sidhdhi.000webhostapp.com/bank/updatetran.php?date=29/9/22&type=debit&amount=1000&reason=fee&userid=7&id=9
                                                        var url = Uri.parse(
                                                            'https://sidhdhi.000webhostapp.com/bank/updatetran.php?date=$date&type=$type&amount=$amt&reason=$res&userid=${widget.d.id}&id=${t.id}');
                                                        var response =
                                                            await http.get(url);
                                                        print(
                                                            'Response status: ${response.statusCode}');
                                                        print(
                                                            'Response body: ${response.body}');
                                                        if (response.body ==
                                                            "data update") {
                                                          t1.text = "";
                                                          grp = "credit";
                                                          t2.text = "";
                                                          t3.text = "";
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                            builder: (context) {
                                                              return second(
                                                                  widget.d);
                                                            },
                                                          ));
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 100,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .deepPurple),
                                                            color: Colors
                                                                .deepPurple,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Text(
                                                          "ADD",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text("Edit")),
                                      TextButton(
                                          onPressed: () async {
                                            //https://sidhdhi.000webhostapp.com/bank/deletetran.php?id=2
                                            var url = Uri.parse(
                                                'https://sidhdhi.000webhostapp.com/bank/deletetran.php?id=${t.id}');
                                            var response = await http.get(url);
                                            print(
                                                'Response status: ${response.statusCode}');
                                            print(
                                                'Response body: ${response.body}');
                                            if (response.body ==
                                                "data deleted") {
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return second(widget.d);
                                                },
                                              ));
                                            }
                                          },
                                          child: Text("Delete")),
                                    ],
                                  );
                                },
                                context: context);
                          },
                          child: Container(
                            color: (index % 2 == 0)
                                ? Colors.white
                                : Colors.black12,
                            height: 35,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${t.date}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (t.type == "credit")
                                            ? Colors.green
                                            : Colors.redAccent),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${t.reason}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: (t.type == "credit")
                                            ? Colors.green
                                            : Colors.redAccent),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    (t.type == "credit")
                                        ? "${t.amount}"
                                        : "---------",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: (t.type == "credit")
                                            ? Colors.green
                                            : Colors.redAccent),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    (t.type == "debit")
                                        ? "${t.amount}"
                                        : "---------",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        color: (t.type == "credit")
                                            ? Colors.green
                                            : Colors.redAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("No Data Yet"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        builder: (context) {
          return SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          softWrap: true,
                          text: TextSpan(
                              children: [
                                WidgetSpan(child: Icon(Icons.upgrade_outlined)),
                                TextSpan(
                                    text: ")",
                                    style: TextStyle(color: Colors.black))
                              ],
                              text: "Credit(",
                              style: TextStyle(color: Colors.black)),
                        ),
                        Text(
                          "\u{20B9} ${cre}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          softWrap: true,
                          text: TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                        Icons.vertical_align_bottom_outlined)),
                                TextSpan(
                                    text: ")",
                                    style: TextStyle(color: Colors.black))
                              ],
                              text: "Debit(",
                              style: TextStyle(color: Colors.black)),
                        ),
                        Text(
                          "\u{20B9} ${deb}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.deepPurple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Balance", style: TextStyle(color: Colors.white)),
                        Text(
                          "\u{20B9} ${bal}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }

  dialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // scrollable: false,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          // actionsOverflowDirection: VerticalDirection.up,
          // contentPadding: EdgeInsets.all(10),
          titlePadding: EdgeInsets.all(0),
          title: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              "Add transaction",
              style: TextStyle(color: Colors.white),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Transaction Date",
                      style: TextStyle(fontSize: 12),
                    )),
                TextField(
                  controller: t1,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(hintText: "Date"),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StatefulBuilder(
                    builder: (context, setState1) {
                      return Row(
                        children: [
                          Text(
                            "Transaction type : ",
                            style: TextStyle(fontSize: 12),
                          ),
                          Radio(
                            value: "credit",
                            groupValue: grp,
                            onChanged: <String>(value) {
                              grp = value;
                              setState1(() {});
                            },
                          ),
                          Text("Credit(+)"),
                          Radio(
                            value: "debit",
                            groupValue: grp,
                            onChanged: <String>(value) {
                              grp = value;
                              setState1(() {});
                            },
                          ),
                          Text("Debit(-)"),
                        ],
                      );
                    },
                  ),
                ),
                TextField(
                  controller: t2,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(hintText: "Amount"),
                ),
                TextField(
                  controller: t3,
                  decoration: InputDecoration(hintText: "Particular"),
                ),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                String date = t1.text;
                String type = grp;
                String amt = t2.text;
                String res = t3.text;
                //https://sidhdhi.000webhostapp.com/bank/inserttran.php?date=27-1-2022&type=debit&amount=24&reason=payingback&userid=2
                var url = Uri.parse(
                    'https://sidhdhi.000webhostapp.com/bank/inserttran.php?date=$date&type=$type&amount=$amt&reason=$res&userid=${widget.d.id}');
                var response = await http.get(url);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                if (response.body == "data inserted") {
                  t1.text = "";
                  grp = "credit";
                  t2.text = "";
                  t3.text = "";
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return second(widget.d);
                    },
                  ));
                }
              },
              child: Container(
                height: 30,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
