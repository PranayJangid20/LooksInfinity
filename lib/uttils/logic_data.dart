import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookinfinity/featues/search/presentation/search_view.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lookinfinity/featues/search/presentation/search_view.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;



var myOrderCart={};
var dataSet;
var rest;

var saleMap;


String serGender = "";
String serType = "";
var serQur= [];
void checkGender(String qur, BuildContext context){

  print('.............');

  serQur = qur.toLowerCase().split(" ");

  //print(serQur);

  if(serQur.contains('men') || serQur.contains('mens') || serQur.contains('boy') || serQur.contains('boys'))
    {
      serGender = "MEN";/*
      serQur.remove("men");
      serQur.remove("mens");
      serQur.remove("boys");
      serQur.remove("boys");*/
    }
  else if(serQur.contains('women') || serQur.contains('girls') || serQur.contains('girl'))
  {
    serGender = "WMN";

    /*serQur.remove("women");
    serQur.remove("girl");
    serQur.remove("girls");*/
  }

  if(serQur.contains('kurta') || serQur.contains('kurti') || serQur.contains('kurte')){
    serType = "kurta";
  }
  else if(serQur.contains('shirt') || serQur.contains('shirts')){
    serType = 'shirt';
  }else if(serQur.contains('tshirt') || serQur.contains('t shirt') || serQur.contains('t-shirt') ||serQur.contains('tshirts') || serQur.contains('t shirts') || serQur.contains('t-shirts')){
    serType = 'tshirt';
  }else if(serQur.contains('top') || serQur.contains('tops')){
    serType = 'top';
  }
  else{
    serType='cloth';
  }

getResult(context);

}


var rstH = [];
var rstM = [];
var rstL = [];

var thresH = 3;
var thresM = 2;
void getResult(BuildContext context)async{

  rstH = [];
  rstM = [];
  rstL = [];

  //print(serGender);
  var rstIndex = [];
  //print(">>>>>>>>>>>>>>>>>");
  //print(dataSet);
  //print(dataSet.docs.length);
  //dataSet.docs
  for(int i = 0;i<dataSet.docs.length;i++){
    var element = dataSet.docs[i];
    //print(element.data()["pId"]+" -- "+(element.data()["pRate"] >600).toString());
    var rstPow = 0;
    if(element.data()["pCatg"] == serGender && element.data()["pTag"].contains(serType)){

      element.data()["pTag"].forEach((i)=>{
        if(serQur.contains(i)){
          rstPow++
        }
      });

      if(rstPow > 0){
        rstIndex.add(i);
        if(rstPow >= thresH) {
          rstH.add(i);
        } else if(rstPow >= thresM){
          rstM.add(i);
        } else{
          rstL.add(i);
        }



      }
      //print(element.data()["pId"]+' -- '+serQur.length.toString()+' -- '+rstPow.toString());
      rstPow = 0;
    }

    else if(serGender == null ){
      element.data()["pTag"].forEach((i)=>{
        if(serQur.contains(i)){
          rstPow++
        }
      });

      if(rstPow > 0){
        rstIndex.add(i);
        if(rstPow >= thresH) {
          rstH.add(i);
        } else if(rstPow >= thresM){
          rstM.add(i);
        } else{
          rstL.add(i);
        }



      }
      //print(element.data()["pId"].toString()+' -- '+serQur.length.toString()+' -- '+rstPow.toString());
      rstPow = 0;
    }
    else{
      //print(serQur);
      element.data()["pTag"].forEach((i)=>{
        if(i==serQur[0]){
          rstPow++
        }
      });

      if(rstPow > 0){
        rstIndex.add(i);
        if(rstPow >= thresH) {
          rstH.add(i);
        } else if(rstPow >= thresM){
          rstM.add(i);
        } else{
          rstL.add(i);
        }



      }
      //print(element.data()["pId"]+' -- '+serQur.length.toString()+' -- '+rstPow.toString());
      rstPow = 0;
    }
    print("this is sorted");
    print(rstH + rstM + rstL);

    print("this is not sorted");
    print(rstIndex);

  }

  print("---- 246 ----");

  print(rstH + rstM + rstL);

  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchView(
        qur: rstH + rstM + rstL,
      )));

}
dbFetch() async {
  dataSet = await FirebaseFirestore.instance.collection("Store").doc("ITEM").collection("itms").get();
  print("ln 181");
  print(dataSet.docs.length);
  print(dataSet.docs[0].data());
  print("///////////////////");
  print(dataSet.docs[1].data());
  print("///////////////////");
  print(dataSet.docs[177].data());
}

Future<void> showMyDialog(BuildContext ctx) async {
  return showDialog<void>(
    context: ctx,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Retry',style: TextStyle(fontFamily: "Taviraj")),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Some thing went wrong',style: TextStyle(fontFamily: "Taviraj")),
              Text('May be Internet not connected',style: TextStyle(fontFamily: "Taviraj")),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Retry'),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
}

