
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddressInputWidget extends StatefulWidget {
  @override
  _AddressInputWidgetState createState() => _AddressInputWidgetState();
}

class _AddressInputWidgetState extends State<AddressInputWidget> {
  String _adr = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            onChanged: (text) {
              _adr = text;
            },
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Change Address',
            ),
          ),
          MaterialButton(
            color: Colors.brown,
            onPressed: (){
              FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser!.uid).update({'adr':_adr.toString()}).whenComplete(() => {Navigator.pop(context)});
            },
            child: Text("Change Address",style: TextStyle(color: Colors.white),),
          )
        ],
      ),
    );
  }
}