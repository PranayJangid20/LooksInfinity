import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/checkout/presentation/confirmed_screen.dart';
import 'package:lookinfinity/uttils/logic_data.dart';

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

var _coupnRemark;
bool haveApply = false;

var cusData;


var pDetail;


int ordBtn = 0;

Map<String, dynamic> oMap = {};

var mahSize;

String FSsize = "";

class CheckoutScreen extends StatefulWidget {
  String pid;
  String size;
  CheckoutScreen({Key ?key, required this.pid, required this.size})
      : super(key: key);
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

var FinalPrice = 0;
var CFFinal = 0;

var check = 1;
 var subs;
 bool intCon = false;
class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _coupnRemark = null;
    check = 1;
    FSsize = widget.size;
    oMap['oPid'] = widget.pid;
    oMap['oSize'] = widget.size;
    mahSize = widget.size;
    ordBtn = 0;

    subs = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        print("mob Connected");
        intCon = true;
        // I am connected to a mobile network.
      } else if (result == ConnectivityResult.wifi) {
        print("wifi Connected");
        intCon = true;
        // I am connected to a wifi network.
      } else if (result == ConnectivityResult.none) {
        print("not Connected");
        intCon = false;
        // I am connected to a wifi network.
      }
    });
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstant.CHECKOUT_BG_COLOR,
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppConstant.ACTION_BG_COLOR,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    boxShadow: [
                       BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10.0,
                      ),
                    ]),
                child: FutureBuilder(
                    future: firestore
                        .collection("Store")
                        .doc("ITEM")
                        .collection("itms")
                        .doc(widget.pid)
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Map<String, dynamic>? data;
                      try {
                        data = snapshot.data.data() as Map<String, dynamic>;
                        oMap['oRate'] = saleMap['actv']? data["pRate"]-saleMap[data["pCatg"]]:data["pRate"];
                        oMap['oName'] = data['pName'];
                        oMap['oSdec'] = data['pSdec'];
                        oMap['oImg'] = data['pImg'][0];
                        FinalPrice = CFFinal = saleMap['actv']? data["pRate"]-saleMap[data["pCatg"]]:data["pRate"];
                        //print(data);
                        pDetail = data;
                      } catch (e) {
                        print(e);
                      }
                      return snapshot.hasData && data != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white54,
                                      boxShadow: [
                                         BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        data['pImg'][0],
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  data['pName'],
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Taviraj"),
                                ),
                                Text(
                                  data['pSdec'],
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),

                                FSsize != 'pQnt'?
                                Column(
                                  children: [
                                    const Text(
                                      "SIZE",
                                      style: TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 1.5,
                                          fontFamily: "Taviraj",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: 50,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1.2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            FSsize,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):
                                SizedBox(width: 50,),
                                Column(
                                  children: [
                                    Text(
                                saleMap['actv']? "₹${data["pRate"]-saleMap[data["pCatg"]]}":"₹${data["pRate"]}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          letterSpacing: 1.5,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const Text(
                                      "TAX INCLUDED",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 9),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : CircularProgressIndicator();
                    }),
              ),
            ),
            SectionDetail()
          ],
        ),
      ),
    );
  }
}

class SectionDetail extends StatefulWidget {
  @override
  _SectionDetailState createState() => _SectionDetailState();
}

class _SectionDetailState extends State<SectionDetail> {

  @override
  Widget build(BuildContext context) {
    return check == 1
        ? Expanded(
            flex: 5,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: AppConstant.WINDOW_BG_COLOR,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: AppConstant.WINDOW_BG_COLOR,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.black),
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: Colors.black26,
                                ),
                                FutureBuilder(
                                    future: firestore
                                        .collection("user")
                                        .doc(auth.currentUser!.uid)
                                        .get(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      Map<String, dynamic>? cus;
                                      try {
                                        cus = snapshot.data.data()
                                            as Map<String, dynamic>;
                                        cusData = cus;
                                        //print('testPrint');
                                        //print(snapshot.data.data());

                                      } catch (e) {
                                        print(e);
                                      }
                                      return snapshot.hasData
                                          ? Text(
                                              cus!['name'] +
                                                  ",\n" +
                                                  cus['adr'] +
                                                  ",\n" +
                                                  cus['numb'],
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          : CircularProgressIndicator();
                                    })
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              check += 1;
                            });
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Payment()),
                              );*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : Expanded(
            flex: 5,
            child: Container(
              color: AppConstant.WINDOW_BG_COLOR,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: const [
                            Text(
                              "PAY ON DELIVERY",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "FOR NOW WE ONLY ACCEPT THIS OPTION" +
                                  '\n'
                                      "SORRY FOR YOUR INCONVINENCE",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /*Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextField(
                                          textInputAction: TextInputAction.search,
                                          onSubmitted: (qur) => {
                                            print(qur),
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.card_giftcard_sharp),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white,
                                                  width: 1.0),
                                            ),
                                            hintText: "Coupon",
                                          ),
                                          style: GoogleFonts.lato(fontSize: 20),
                                          textAlign: TextAlign.justify,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                child: Column(
                              children: [
                                _coupnRemark != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Coupon Applied ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            '-' + '30',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Product ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      pDetail['pRate'].toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    Text(
                                      (pDetail['pRate'] - 30).toString(),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            )),*/
                            BillingPanel()
                          ],
                        ),
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          var currDt = DateTime.now();
                          int curTime = currDt.millisecondsSinceEpoch;
                          oMap['oCus'] = auth.currentUser.uid;
                          oMap['oCoup'] =
                              _coupnRemark != null ? _coupnRemark['dic'] : "none";
                          oMap['oCD'] =
                              _coupnRemark != null ? _coupnRemark['dic'] : 0;
                          oMap['oAdr'] = cusData['adr'];
                          oMap['oFRate'] = CFFinal;
                          oMap['oTime'] = curTime;
                          oMap['status'] = 'order';

                          //print((oMap));

                          CollectionReference users = FirebaseFirestore.instance
                              .collection('user')
                              .doc(auth.currentUser.uid)
                              .collection('order');

                          // Call the user's CollectionReference to add a new user
                          users.doc(currDt.millisecondsSinceEpoch.toString())
                              .set(oMap).whenComplete(() => {
                            mahSize != null
                                ? firestore
                                .collection('Store')
                                .doc('ITEM')
                                .collection('itms')
                                .doc(pDetail['pId'])
                                .update({
                              mahSize: FieldValue.increment(-1),
                            }).whenComplete(() => {
                              check = 1,
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Confirmed(oId: currDt.millisecondsSinceEpoch.toString(),)))
                            }).onError((error, stackTrace) => print(error))
                                : firestore
                                .collection('Store')
                                .doc('ITEM')
                                .collection('itms')
                                .doc(pDetail['pId'])
                                .update({
                              'qnt': FieldValue.increment(-1),
                            })
                          })
                              .catchError(
                                  (error) => print("Failed to add user: $error"));

                          print(pDetail['pId'] +
                              pDetail['pRate'].toString() +
                              FSsize);
                          *//*
                          setState(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Confirmed()));
                                      });*//*
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => Confirmed()),
//                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              "CONFIRM ORDER",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
            ),
          );
  }
}

class BillingPanel extends StatefulWidget {
  const BillingPanel({super.key});

  @override
  _BillingPanelState createState() => _BillingPanelState();
}

class _BillingPanelState extends State<BillingPanel> {

  applyCoupon(map) {
    _coupnRemark = map;
    setState(() {
      haveApply = true;
      CFFinal = FinalPrice;
      print(map == null);
      if (map == null || _coupnRemark['leng']<0) {
        _coupnRemark = null;
      }
      else{
      //print("tish is cal");
      //print(_coupnRemark['dic']);
      CFFinal -= int.parse(_coupnRemark['dic'].toString());
      //print(FinalPrice.toString() + " -- " + CFFinal.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                textInputAction: TextInputAction.search,
                                onSubmitted: (qur) => {
                                  //print(qur),
                                  firestore
                                      .collection('coupon')
                                      .doc(qur.toString())
                                      .get()
                                      .then((value) => {
                                    applyCoupon(value.data()),

                                    _coupnRemark = value.data(),

                                  })
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.card_giftcard_sharp),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  hintText: "Coupon",
                                ),
                                style: GoogleFonts.lato(fontSize: 20),
                                textAlign: TextAlign.justify,
                                textAlignVertical: TextAlignVertical.bottom,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Column(
                        children: [
                          _coupnRemark != null
                              ? Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Coupon Applied ',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 15),
                              ),
                              Icon(Icons.check,color: Colors.green,size: 15,)
                            ],
                          )
                              : Text(
                            haveApply?'Coupon Invalid':"",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Product ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                Text(
                                  FinalPrice.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 0.4,
                            color: Colors.black45,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Coupon',
                                style:
                                TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                _coupnRemark != null
                                    ? _coupnRemark['dic'].toString()
                                    : 0.toString(),
                                style:
                                const TextStyle(color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black87,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total ',
                                style:
                                TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                CFFinal.toString(),
                                style:
                                TextStyle(color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () {
                  if(ordBtn == 0) {

                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

                    ordBtn = 1;
                    var currDt = DateTime.now();
                    int curTime = currDt.millisecondsSinceEpoch;
                    oMap['oCus'] = auth.currentUser!.uid;
                    oMap['oCoup'] =
                    _coupnRemark != null ? _coupnRemark['dic'] : "none";
                    oMap['oCD'] =
                    _coupnRemark != null ? _coupnRemark['dic'] : 0;
                    oMap['oAdr'] = cusData['adr'];
                    oMap['oFRate'] = CFFinal;
                    oMap['oTime'] = curTime;
                    oMap['status'] = 'ordered';
                    oMap['cartSize'] = 1;
                    oMap['cartType'] = 'inst';

                    //print((oMap));

                    CollectionReference users = FirebaseFirestore.instance
                        .collection('user')
                        .doc(auth.currentUser!.uid)
                        .collection('order');

                    // Call the user's CollectionReference to add a new user
                    users.doc(currDt.millisecondsSinceEpoch.toString())
                        .set(oMap).whenComplete(() =>
                    {
                      mahSize != null
                          ? firestore
                          .collection('Store')
                          .doc('ITEM')
                          .collection('itms')
                          .doc(pDetail['pId'])
                          .update({
                        mahSize: FieldValue.increment(-1),
                      }).whenComplete(() =>
                      {
                        check = 1,
                        if(_coupnRemark != null){
                          firestore
                              .collection('coupon')
                              .doc(_coupnRemark['name'])
                              .update({
                            'leng': FieldValue.increment(-1),
                            'count': FieldValue.increment(1),
                          }).then((value) =>
                          {


                            firestore.collection("orders").doc('orders')
                                .collection(currDt.month.toString() +
                                currDt.year.toString()).add(oMap)
                                .whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmedScreen(
                                            oId: currDt.millisecondsSinceEpoch
                                                .toString(),)));
                            })
                          })
                        } else
                          {


                            firestore.collection("orders").doc('orders')
                                .collection(currDt.month.toString() +
                                currDt.year.toString()).add(oMap)
                                .whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConfirmedScreen(
                                            oId: currDt.millisecondsSinceEpoch
                                                .toString(),)));
                            })
                          },


                      }).onError((error, stackTrace) => print(error))
                          : firestore
                          .collection('Store')
                          .doc('ITEM')
                          .collection('itms')
                          .doc(pDetail['pId'])
                          .update({
                        'qnt': FieldValue.increment(-1),
                      })
                    })
                        .catchError(
                            (error) => print("Failed to add user: $error"));

                    //print(pDetail['pId'] + pDetail['pRate'].toString() + FSsize);

                    /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartConfirmd(img: mahCartImage)),
                  );*/
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 5),
                    child: Text(
                      "CONFIRM ORDER",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
