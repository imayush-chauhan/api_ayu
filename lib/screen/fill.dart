import 'package:api_ay/data/data.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info.dart';

class Fill extends StatefulWidget {
  final int inx;
  Fill({required this.inx});

  @override
  _FillState createState() => _FillState();
}

class _FillState extends State<Fill> {

  TextEditingController age = TextEditingController();
  final ageKey = GlobalKey<FormState>();

  bool onPress = false;
  int gender = 1;

  set() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {
      myPrefs.setStringList("signIn", Data.signIn);
      myPrefs.setStringList("signInAge", Data.signInAge);
      myPrefs.setStringList("signInGender", Data.signInGender);
    });
  }

  setData(){
    Data.signIn.add(widget.inx.toString());
    Data.signInAge.add(age.text);
    Data.signInGender.add(gender.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff4E24A3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.8,
                child: Form(
                  key: ageKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: age,
                    validator: (val){
                      return int.parse(age.text)  <= 18 ? "Age is less then 18" : null;
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    autofocus: false,
                    textAlign: TextAlign.left,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Age in number',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      prefixIcon: Container(
                        height: 50,
                        width: 80,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Age",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              ),),
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text("Gender :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap:(){
                            setState(() {
                              gender = 1;
                            });
                            },
                          child: Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            alignment: Alignment.center,
                            child: gender != 1 ?
                            Text("Male",
                              style: TextStyle(
                                  color: Color(0xff4E24A3),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600
                              ),) :
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check,color: Colors.greenAccent,),
                                    Text("Male",
                                      style: TextStyle(
                                          color: Color(0xff4E24A3),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),)
                                  ],
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap:(){
                              setState(() {
                                gender = 2;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              alignment: Alignment.center,
                              child: gender != 2 ?
                              Text("Female",
                                style: TextStyle(
                                    color: Color(0xff4E24A3),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                ),) :
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.check,color: Colors.greenAccent,),
                                  Text("Female",
                                    style: TextStyle(
                                        color: Color(0xff4E24A3),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    onPress = true;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      setState(() {
                        onPress = false;
                        if(ageKey.currentState!.validate()){
                          setData();
                          set();
                          print(Data.signIn);

                          Navigator.pushReplacement(context, PageTransition(
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: Info(inx: widget.inx,),
                          ));
                          // print(Data.signInAge.elementAt(widget.inx));
                          // print(Data.signInGender.elementAt(widget.inx));
                        }
                      });
                    });
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 350),
                  width: onPress == false ?
                  MediaQuery.of(context).size.width*0.75 :
                  MediaQuery.of(context).size.width*0.75 - 25,
                  height: onPress == false ? 50 : 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.5),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text("Continue",
                    style: TextStyle(
                        color: Color(0xff4E24A3),
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
