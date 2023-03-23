import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/account/presentation/my_wishlist_screen.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/search/presentation/search_view.dart';
import 'package:lookinfinity/featues/authentication/presentation/login_screen.dart';
import 'package:lookinfinity/common/user.dart';
import '../logic.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SearchActivity extends StatefulWidget {
  @override
  _SearchActivityState createState() => _SearchActivityState();
}

class _SearchActivityState extends State<SearchActivity> {
  @override
  void initState() {
    // TODO: implement initState

      createDatabase();

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    String qurry = '';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 50,
          backgroundColor: AppConstant.APPBAR_BACKGROUND_COLOR,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Image.asset(
            'Assets/images/Infi.png',
            height: 40,
          ),
          centerTitle: false,
          /*leading: Icon(
            Icons.sort,
            size: MediaQuery.of(context).size.width/12,
            color: Colors.black,
          ),*/
          actions: [

          ],
        ),
        backgroundColor: Colors.grey.shade200,
        body: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'Assets/images/Infi.png',
                    width: 50,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onSubmitted: (qur)=>{
                          if (qur.toString().trim().length > 2) {
                            checkGender(qur, context),


                            /*Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LProd(
                              qur: text,
                            )))*/
                          }
                        },
                        maxLines: 1,
                        onChanged: (text) {
                          qurry = text;
                        },
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  //IconButton(onPressed: ()=>searchFor(context,qurry), icon: Icon(Icons.search_rounded),)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              checkGender(qurry,context);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search_rounded,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Example - Black Shirt L",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Example - Orange Kurta XL Half-Sleve",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        Text(""),
                        Text(
                          "Please Enter Your Requirments like - Color, Type, Size, Style, Etc.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
