import 'package:cloud_firestore/cloud_firestore.dart';

var userId;
var mob;
var name;
var gender;
var address;

var taC;
var careNum;
var careMail;

bool authState = false;
var authUser;


FirebaseFirestore firestore = FirebaseFirestore.instance;

class InfoUser{
  bool Reg = false;
}

InfoUser infoUser = new InfoUser();