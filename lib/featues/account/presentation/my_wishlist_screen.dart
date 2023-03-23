import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/checkout/presentation/checkout_screen.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/checkout/presentation/cart_checkout_screen.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
import '../../search/presentation/search_view.dart';
import 'package:lookinfinity/uttils/cusInfom.dart';

import '../widget/cart_window.dart';

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

/*itms size arrays same as cloth with o in it and o to qnt value*/

class MyWishList extends StatefulWidget {
  @override
  _MyWishListState createState() => _MyWishListState();
}

var mycartTo;

var wishList = [];

var tCart = 0;

class _MyWishListState extends State<MyWishList> {
  @override
  void initState() {
    myOrderCart={};
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
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
                Text(
                  "CART",
                  style: TextStyle(color: Colors.white),
                ),
                // Image.asset(
                //   'Assets/images/Infi.png',
                //   width: 50,
                // ),
              ],
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: firestore
                          .collection("user")
                          .doc(auth.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snap) {
                        //print(snap.data.data()['whl']);
                        return snap.hasData
                            ? StreamBuilder(
                                stream: firestore
                                    .collection("Store")
                                    .doc("ITEM")
                                    .collection('itms')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    wishList = [];
                                    myOrderCart = {};

                                    //Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
                                    for (int i = 0;
                                        i < snap.data?.data()!['whl'].length;
                                        i++) {
                                      for (int j = 0;
                                          j < snapshot.data!.docs.length;
                                          j++) {
                                        if (snapshot.data!.docs[j]
                                                .data()['pId'] ==
                                            snap.data!.data()?['whl'][i]) {
                                          wishList.add(
                                              snapshot.data?.docs[j].data());

                                          myOrderCart[snap.data!.data()?['whl']
                                                  [i]] =
                                              snapshot.data?.docs[j]
                                                  .data()['pSize'][0];
                                          tCart += int.parse(snapshot.data!.docs[j]
                                              .data()['pRate'].toString());
                                          //print(wishList[0]);
                                        }
                                      }
                                    }
                                    print("-------------------cart Total" +
                                        tCart.toString());
                                    //print(myOrderCart);
                                  }
                                  return snapshot.hasData ?
                                  snap.data!.data()!['whl'].length>0?
                                  ListView.builder(
                                          itemCount:
                                              snap.data!.data()!['whl'].length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CartView(
                                              cartData: wishList[index],
                                            );
                                          },
                                        )
                                  :Center(child: Text("Your Order cart is Empty".toUpperCase(),style: TextStyle(color:Colors.blueGrey),))
                                      : Container();
                                })
                            : const Center(child: CircularProgressIndicator());
                      }),
                ),
                Container(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: MaterialButton(
                    onPressed: () {
                      if(myOrderCart != {}) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartCheckoutScreen(myCartTO: myOrderCart)),
                        );
                      }
                    },
                    color: AppConstant.ACTION_BG_COLOR,
                    minWidth: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "CHECKOUT",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
