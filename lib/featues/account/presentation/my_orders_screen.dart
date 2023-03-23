import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/featues/checkout/presentation/confirmed_screen.dart';
import 'package:lookinfinity/featues/checkout/presentation/cart_confirmed_screen.dart';
import 'package:lookinfinity/featues/account/widget/cart_window.dart';


FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class OrderActivity extends StatefulWidget {
  @override
  _OrderActivityState createState() => _OrderActivityState();
}

class _OrderActivityState extends State<OrderActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        toolbarHeight: 50,
        backgroundColor: Color(0XFFEEEEEE),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Row(
          children: [
            Text("MY ORDERS", style: TextStyle(color: Colors.black),),
            Image.asset(
              'Assets/images/Infi.png',width: 50,
            ),
          ],
        ),



      ),
      body: FutureBuilder(
        future:firestore
            .collection("user")
            .doc(auth.currentUser!.uid)
            .collection('order')
            .get(),
          builder: (BuildContext context,
              AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              print('This Is Data');
              print(snapshot.data.docs.length>0);
            }
            return snapshot.hasData ?
            snapshot.data.docs.length>0?
            ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return snapshot.hasData ?
                  snapshot.data.docs[index].data()['cartType'] == 'inst' ?
                  CartWindow(cartData: snapshot.data.docs[index].data()) :
                  MultCartWindow(cartData: snapshot.data.docs[index].data())
                    : CircularProgressIndicator();
              },
            )
            :Center(child: Text("You have not ordered yet! ORDER NOW".toUpperCase(),style: TextStyle(color:Colors.blueGrey),))
                : CircularProgressIndicator();
          }),
    );
  }
}
