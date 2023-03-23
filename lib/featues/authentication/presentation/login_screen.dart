import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'dart:ui';

import 'package:lookinfinity/featues/Home/presentation/home.dart';
import 'package:lookinfinity/featues/authentication/presentation/registration_form.dart';
import 'package:lookinfinity/main.dart';
import 'package:lookinfinity/common/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

late String Otp;

var sysOtp;
int otp = 0;
bool numBool = true;

late String Numb;

bool _btnVer = false;

class _LoginScreenState extends State<LoginScreen> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future userIn() async {
    await auth.verifyPhoneNumber(
      phoneNumber: Numb,

      /////////////////////////////////////////////////////////////////////////
      //Auto Code Retrival
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (Reg) {
          var result = await auth.signInWithCredential(credential);

          userId = result.user!.uid;

          if (userId != null) {
            Navigator.pop(context);
          } else {
            print("error!!!!!");
          }
        }
      },
      ////////////////////////////////////////////////////////////////////////
      verificationFailed: (FirebaseAuthException error) {

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message.toString())));

        print("Verification Failed ${error.message}");
        setState(() {
          otp = 0;
          numBool = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        setState(() {
          otp = 1;
          sysOtp = verificationId;
        });
      },
    );
  }

  double hgtCal(int nm) {
    var sum = MediaQuery.of(context).size.height * nm;
    return sum / 100;
  }

  double widthCal(int nm) {
    var sum = MediaQuery.of(context).size.width * nm;
    return sum / 100;
  }

  bool Reg = true;


  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstant.BACKGROUND_COLOR,
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: AppConstant.ACTION_BG_COLOR,
          child: Icon(Icons.arrow_back),
        ),*/
        body: SingleChildScrollView(
          child: Center(
            child: /*Reg?*/ Column(
              children: [
                Image.asset(
                  "Assets/images/log_in_banner.png",
                  width: double.infinity,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: numBool,
                    onChanged: (text) {
                      Numb = "+91$text";
                    },
                    maxLines: 1,
                    maxLength: 12,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      prefix: Text("+91 "),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFFB299A1))),
                      labelText: 'Mobile Number',
                    ),
                  ),
                ),
                otp == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            if (numBool == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const <Widget>[
                                      Text("Wait For OTP..."),
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              firestore
                                  .collection("user")
                                  .where("numb", isEqualTo: Numb)
                                  .get()
                                  .then((value) => {
                                        print(value.docs.length),
                                        if (value.docs.length == 1)
                                          {
                                            if (Numb.length > 9)
                                              {
                                                numBool = false,
                                                print("Welcome Back"),
                                                print(value.docs[0].id),
                                                Reg = true,
                                                OldUserLog(),
                                                //UserIn();
                                              }
                                            else
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Invalid Number"),
                                                )),
                                              }
                                          }
                                        else if (value.docs.length == 0)
                                          {
                                            if (Numb.length > 9)
                                              {
                                                numBool = false,
                                                Reg = false,
                                                print("ohh Your New"),
                                                NewUserLog(),
                                                //UserIn();
                                              }
                                            else
                                              {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text("Invalid Number"),
                                                )),
                                              }
                                          }
                                        else if (value.docs.length > 1)
                                          {
                                            ////Report/////
                                          }
                                        /*value.docs.forEach((element) {
                                })*/
                                      });
                              setState(() {

                              });
                            }
                            /*setState(() {
                              print("Number - " + Numb);
                              if (Numb.length > 9) {
                                numBool = false;

                                //UserIn();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Invalid Number"),
                                ));
                              }
                            });*/
                          },
                          color: Color(0XFF08B7D2),
                          minWidth: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: numBool? Text(
                              "GET OTP",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                                :CircularProgressIndicator(),
                          ),
                          height: 50,
                        ),
                      )
                    : Reg == true
                        ? Column(
                            children: [
                              LogForm(),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      otp = 0;
                                      numBool = true;
                                    });
                                  },
                                  child: Text(
                                    "Change Number",
                                    style: TextStyle(color: AppConstant.CHANGE_INFO_COLOR),
                                  )),
                            ],
                          )
                        : Column(
                            children: [
                              RegistrationForm(),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      otp = 0;
                                      numBool = true;
                                    });
                                  },
                                  child: Text(
                                    "Change Number",
                                    style: TextStyle(color: AppConstant.CHANGE_INFO_COLOR),
                                  )),
                            ],
                          )
                //LogForm()
              ],
            )
            //:LogForm()
            ,
          ),
        ),
      ),
    );
  }

  OldUserLog() {
    Reg = true;
    userIn();
  }

  NewUserLog() {
    Reg = false;
    userIn();
  }
}

class LogForm extends StatefulWidget {
  @override
  _LogFormState createState() => _LogFormState();
}

class _LogFormState extends State<LogForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                Otp = text;
              },
              maxLines: 1,
              maxLength: 12,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'OTP',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              minWidth: double.infinity,
              onPressed: () async {
                print("----------->>>>>>>>>>>>>>>>>>>>>>");
                if (Otp.trim().length > 5) {
                  AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: sysOtp, smsCode: Otp.trim());

                  var result = await auth.signInWithCredential(credential);

                  userId = result.user!.uid;

                  if (userId != null) {
                    otp = 0;
                    numBool = true;

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } else {
                    print("error!!!!!");
                  }

                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Home()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "VERIFY",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              color: AppConstant.CHANGE_INFO_COLOR,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
