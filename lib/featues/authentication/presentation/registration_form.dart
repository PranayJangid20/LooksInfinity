
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/home/presentation/home.dart';
import 'package:lookinfinity/common/user.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late String _adr, _name, _numb, Otp, sysOtp;
  int otp = 0;
  bool numBool = true;


  FirebaseAuth auth = FirebaseAuth.instance;

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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'OTP',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                _name = text;
              },
              maxLines: 1,
              maxLength: 20,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: TextField(
              onChanged: (text) {
                _adr = text;
              },
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: const Text(
                  "Jodhpur,Rajasthan,India",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              minWidth: double.infinity,
              onPressed: () async {
                if (Otp.trim().length > 5 && _name.length>0 && _adr.length>5 ) {
                  AuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: sysOtp, smsCode: Otp.trim());

                  var result = await auth.signInWithCredential(credential);

                  userId = result.user!.uid;

                  if (userId != null) {
                    var dataMap = {
                      "name": _name,
                      "adr": _adr,
                      "numb": _numb,
                      "tags": [],
                      "whl":[]
                    };

                    FirebaseFirestore.instance
                        .collection('user')
                        .doc(userId)
                        .set(dataMap)
                        .whenComplete(() => {
                      otp = 0,
                      numBool = true,
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home())),
                    });
                  } else {
                    print("error!!!!!");
                  }

                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Home()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const  SnackBar(
                    content: Text("Invalid OTP"),
                  ));
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: AppConstant.CHANGE_INFO_COLOR,
              height: 50,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "VERIFY",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
