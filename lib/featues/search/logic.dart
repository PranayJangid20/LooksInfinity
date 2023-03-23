
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/uttils/tempPdList.dart';

void createDatabase()async{
  print('||||||||||||||||||||');
  dataSet = await FirebaseFirestore.instance
      .collection("Store")
      .doc("ITEM")
      .collection("itms").get();



  //print(dataSet.runtimeType);
}


void searchIncloth(context, qur) {
  if (qur.toString().trim().length > 2) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LProd(
          qur: qur,
        )));
  }
}

void searchInjwell(context, qur) {
  if (qur.toString().trim().length > 2) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LProd(qur: qur)));
  }
}

void searchInaccs(context, qur) {
  if (qur.toString().trim().length > 2) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LProd(qur: qur)));
  }
}
