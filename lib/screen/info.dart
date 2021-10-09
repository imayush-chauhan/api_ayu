import 'package:api_ay/data/data.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final int inx;
  Info({required this.inx});
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff4E24A3),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 140,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(Data.apiData[0]["users"][widget.inx]["name"]),
            ),
            Container(
              height: 70,
              width: 140,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(Data.signInAge[Data.signIn.indexOf(widget.inx.toString())]),
            ),
            Container(
              height: 70,
              width: 140,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                  Data.signInGender[Data.signIn.indexOf(widget.inx.toString())] == "1" ?
                      "Male" : "female"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
