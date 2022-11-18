import 'package:balanceapp/dashboard.dart';
import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();

    next();
  }

  next() async {
    await Future.delayed(Duration(seconds: 1));

    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return dashboard();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blueGrey, Colors.grey])),
        child: Center(
          child: Text(
            "Account Manager",
            style: TextStyle(fontSize: 34),
          ),
        ),
      ),
    );
  }
}
