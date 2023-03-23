import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/account/presentation/my_orders_screen.dart';
import 'package:lookinfinity/featues/account/presentation/my_wishlist_screen.dart';
import 'package:lookinfinity/common/user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/address_input_widget.dart';


class MyAcount extends StatefulWidget {
  const MyAcount({super.key});

  @override
  _MyAcountState createState() => _MyAcountState();
}


class _MyAcountState extends State<MyAcount> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppConstant.BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: 50,
        backgroundColor: AppConstant.APPBAR_BACKGROUND_COLOR,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Row(
          children: [
            const Text(
              "ACCOUNT",
              style: TextStyle(color: Colors.white),
            ),
            Image.asset(
              'Assets/images/Infi.png',
              width: 50,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().whenComplete(() => {Navigator.pop(context)});
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 30, right: 15.0),
          child: StreamBuilder(
            stream: firestore.collection("user").doc(auth.currentUser!.uid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.data["name"],
                      style: GoogleFonts.roboto(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Divider(
                        thickness: 0.5,
                        color: AppConstant.DIVIDER_BLACK_COLOR,
                      ),
                    ),
                    Text(
                      snapshot.data['numb'],
                      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Divider(
                        thickness: 0.5,
                        color: AppConstant.DIVIDER_BLACK_COLOR,
                      ),
                    ),
                    Text(
                      snapshot.data["adr"].toString(),
                      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Divider(
                        thickness: 0.5,
                        color: Color(0XFF707070),
                      ),
                    ),

                    Container(
                        width: double.infinity,
                        child: Center(
                            child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return AddressInputWidget();
                                      });
                                },
                                child: const Text(
                                  "Change Info",
                                  style: TextStyle(color: AppConstant.CHANGE_INFO_COLOR),
                                )))),

                    //Text('Male',style: GoogleFonts.roboto(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.bold),),
                    /*Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Divider(thickness: 0.5,color: Color(0XFF707070),),
                ),*/
                    /*Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0XFF9CFF2D),width: 2),
                        ),
                        child: Column(
                          children: [
                            Text("Orders ->"),
                            Expanded(flex:5,child: Center(child: Text("00",style: TextStyle(fontSize: 25),))),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0XFFFFD52D),width: 2),
                        ),
                        child: Column(
                          children: [
                            Text("WishList ->"),
                            Expanded(flex:5,child: Center(child: Text("00",style: TextStyle(fontSize: 25),))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderActivity()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Orders',
                            style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Divider(
                        thickness: 1,
                        color: AppConstant.DIVIDER_BLACK_COLOR,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyWishList()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cart',
                            style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Divider(
                        thickness: 1,
                        color: AppConstant.DIVIDER_BLACK_COLOR,
                      ),
                    ),
                    Text(
                      'Help And Support',
                      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Divider(
                        thickness: 1,
                        color: AppConstant.DIVIDER_BLACK_COLOR,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              launch("tel://$careNum");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(careNum.toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () {
                              launch("mailto:$careMail");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(careMail.toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Terms And Condition',
                      style: GoogleFonts.roboto(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Divider(
                        thickness: 1,
                        color: AppConstant.DIVIDER_BLACK_COLOR,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              launch(taC);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Click To See Our Policies',
                                    style: GoogleFonts.lato(
                                      fontSize: 20,
                                      color: Colors.black,
                                    )),
                                Container(
                                  decoration:
                                      BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
                                  child:  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.web_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )),
    ));
  }

  void _launchTAC() async => await canLaunch(taC) ? await launch(taC) : throw 'Could not launch $taC';
}
