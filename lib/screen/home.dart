import 'dart:convert';

import 'package:api_ay/data/data.dart';
import 'package:api_ay/screen/fill.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String api = "https://raw.githubusercontent.com/imayush-chauhan/PokeInfo/main/Data.json";

  @override
  void initState() {
    super.initState();
    getData();
    get();
  }



  getData() async{
    var response =
    await http.get(
        Uri.https(
            "raw.githubusercontent.com",
            "imayush-chauhan/PokeInfo/main/Data.json"));
    setState(() {
      Data.apiData = jsonDecode(response.body);
      if(Data.apiData != []){
        Data.isData = true;
      }
      print(Data.apiData[0]);
      print(Data.apiData[0]["users"][0]["name"]);
    });
  }

  set() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {
      myPrefs.setStringList("signIn", Data.signIn);
    });
  }

  get() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if(myPrefs.getStringList("signIn") != null ){
      setState(() {
        Data.signIn = myPrefs.getStringList("signIn")!;
        Data.signInAge = myPrefs.getStringList("signInAge")!;
        Data.signInGender = myPrefs.getStringList("signInGender")!;
      });
    }
    print(Data.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Users",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Color(0xff4E24A3),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff4E24A3),
        ),
        alignment: Alignment.topCenter,
        child: Data.isData == true ?
        ListView.builder(
          itemCount: Data.apiData[0]["users"].length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      // Data.signIn.clear();
                      // set();
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width*0.52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(Data.apiData[0]["users"][index]["name"],
                            style: TextStyle(
                              color: Color(0xff4E24A3),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(Data.signIn.contains(index.toString())){
                        Navigator.push(context, PageTransition(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 500),
                          type: PageTransitionType.rightToLeft,
                          child: Info(inx: index,),
                        ));
                      }else{
                        Navigator.push(context, PageTransition(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 500),
                          type: PageTransitionType.rightToLeft,
                          child: Fill(inx: index,),
                        ));
                      }
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[700],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                      child: Data.signIn.contains(index.toString()) ?
                      Text("Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),) :
                      Text("Sing up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                  )
                ],
              ),
            );
          },
        ) :
        Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
