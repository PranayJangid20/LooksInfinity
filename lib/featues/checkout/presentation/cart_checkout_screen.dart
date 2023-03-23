import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/checkout/presentation/cart_confirmed_screen.dart';
import 'package:lookinfinity/uttils/cusInfom.dart';

//INFO: ****This Fille IS EXAMPLE OF BAD MANAGEMENT****
FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

var myCartPrd;

var _coupnRemark;

var wishList = [];

Map<String, dynamic> cus = {};

Map<String, dynamic> cMap = {};

var mahCartImage = [];

var mahCartTotal = 0;

var mahFinalCartTotal = 0;

var mahCartDetail = {};

var myCartInst;

int cartItm = 0;

int ordBtn = 0;

var arrCagType = [];

class CartCheckoutScreen extends StatefulWidget {
  var myCartTO;
  CartCheckoutScreen({@required this.myCartTO});
  @override
  _CartCheckoutScreenState createState() => _CartCheckoutScreenState();
}

var subs;
var intCon = false;

class _CartCheckoutScreenState extends State<CartCheckoutScreen> {
  @override
  void initState() {
    subs = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
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
    // TODO: implement initState
    super.initState();
    _coupnRemark = null;
    ordBtn = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    myCartInst = widget.myCartTO;

    //print(widget.myCartTO);
    return Scaffold(
        backgroundColor: AppConstant.BACKGROUND_COLOR,
        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 50,
          backgroundColor: AppConstant.APPBAR_BACKGROUND_COLOR,
          title: Image.asset(
            'Assets/images/Infi.png',
            height: 40,
          ),
          centerTitle: true,
          /*leading: Icon(
            Icons.sort,
            size: MediaQuery.of(context).size.width/12,
            color: Colors.black,
          ),*/
        ),
        body: FutureBuilder(
            future: firestore.collection("user").doc(auth.currentUser!.uid).get(),
            builder: (context, snap) {
              //print(snap.data.data()['whl']);
              return snap.hasData
                  ? FutureBuilder(
                      future: firestore.collection("Store").doc("ITEM").collection('itms').get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          wishList = [];

                          mahCartTotal = 0;
                          mahCartImage = [];
                          mahCartDetail = {};

                          cartItm = 0;

                          //print(widget.myCartTO.keys.toList().length);

                          myCartPrd = widget.myCartTO.keys.toList();
                          print("pg---125");
                          print(myCartPrd);

                          //Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
                          createFinalCart(snapshot,myCartPrd,widget.myCartTO);

                          mahFinalCartTotal = mahCartTotal;

                          print('my cart total - ' + mahCartTotal.toString());
                        }
                        return snapshot.hasData
                            ? Column(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: ListView.builder(
                                      itemCount: myCartPrd.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return CartPanel(
                                          cartData: wishList[index],
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                      flex: 6,
                                      child: FutureBuilder(
                                          future: firestore.collection("user").doc(auth.currentUser!.uid).get(),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            try {
                                              cus = snapshot.data.data() as Map<String, dynamic>;

                                              //print('testPrint');
                                              //print(snapshot.data.data());

                                            } catch (e) {
                                              print(e);
                                            }
                                            return snapshot.hasData
                                                ? Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            'Delivery Address : ' +
                                                                "\n" +
                                                                cus['name'] +
                                                                ",\n" +
                                                                cus['adr'] +
                                                                ",\n" +
                                                                cus['numb'],
                                                            style: GoogleFonts.quicksand(fontSize: 15),
                                                          ),
                                                        ),
                                                        Divider(
                                                          thickness: 0.5,
                                                          color: Colors.grey,
                                                        ),
                                                        BillingPanel(),
                                                      ],
                                                    ),
                                                  )
                                                : Center(child: CircularProgressIndicator());
                                          }))
                                ],
                              )
                            : Container();
                      })
                  : Center(child: CircularProgressIndicator());
            }));
  }
}

void createFinalCart(var snapshot,var myCartPrd, var myCartTO){
  for (int i = 0; i < myCartPrd.length; i++) {
    for (int j = 0; j < snapshot.data!.docs.length; j++) {
      if (i >= myCartPrd.length) {
        break;
      }
      if (snapshot.data!.docs[j].data()['pId'] == myCartPrd[i]) {
        print(snapshot.data!.docs[j].data()['pId'] + " -^- " + myCartPrd[i]);
        wishList.add(snapshot.data!.docs[j].data());
        arrCagType.add(snapshot.data!.docs[j].data()['pCatg']);
        if (saleMap['actv'] == true && saleMap[snapshot.data!.docs[j].data()['pCatg']] != 0) {
          mahCartTotal += int.parse(snapshot.data!.docs[j].data()['pRate'] -
              saleMap[snapshot.data!.docs[j].data()['pCatg']].toString());
        } else {
          mahCartTotal += int.parse(snapshot.data!.docs[j].data()['pRate'].toString());
        }
        print(mahCartTotal.toString() +
            " -- " +
            snapshot.data!.docs[j].data()['pRate'].toString());
        mahCartImage.add(snapshot.data!.docs[j].data()['pImg'][0]);
        mahCartDetail[i.toString()] = snapshot.data!.docs[j].data();
        mahCartDetail[i.toString()]['status'] = 'order';
        cartItm += 1;
        mahCartDetail[i.toString()]['pSize'] =
        myCartTO[snapshot.data!.docs[j].data()['pId']];
      }
    }
  }
}

class CartPanel extends StatefulWidget {
  var cartData;
  CartPanel({@required this.cartData});
  @override
  _CartPanelState createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  @override
  Widget build(BuildContext context) {
    double hSize(double Percentage) {
      return (MediaQuery.of(context).size.height * Percentage) / 100;
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 5,
      ),
      margin: EdgeInsets.only(top: 5),
      height: hSize(15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              widget.cartData['pImg'][0],
              height: hSize(12),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.cartData['pName'],
                        style: TextStyle(
                            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w800, fontFamily: "Taviraj"),
                      ),
                      Text(
                        widget.cartData['pSdec'].toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Expanded(
                          child: widget.cartData['pSize'][0] != 'pQnt'
                              ? Text(
                                  myOrderCart[widget.cartData['pId']].toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              : Container()),
                    ],
                  ),
                )),
            Expanded(
                child: Text(
              saleMap[widget.cartData['pCatg']] != 0 && saleMap['actv']
                  ? '₹' + (widget.cartData['pRate'] - saleMap[widget.cartData['pCatg']]).toString()
                  : '₹' + widget.cartData['pRate'].toString(),
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class BillingPanel extends StatefulWidget {
  @override
  _BillingPanelState createState() => _BillingPanelState();
}

var coupMark = "Coupon Applied";
var isap = false;

class _BillingPanelState extends State<BillingPanel> {
  applyCoupon(map) {
    if (arrCagType.contains('MEN') || arrCagType.contains('WMN') || arrCagType.contains('DCR')) {
      isap = true;

      print("check" + isap.toString());
      print(arrCagType);
    }
    /*for(int i = 0;i<arrCagType.length;i++){
      if(arrCagType[i] == )
    }*/
    _coupnRemark = map;

    setState(() {
      if (isap) {
        mahFinalCartTotal = mahCartTotal;
        print(map == null);
        print(map != null);

        if (map == null || _coupnRemark['leng'] < 0) {
          _coupnRemark = null;
          coupMark = "Not Aplicable";
        } else {
          //print("tish is cal");
          //print(_coupnRemark['dic']);
          mahFinalCartTotal -= int.parse(_coupnRemark['dic'].toString());
          //print(mahCartTotal.toString() + " -- " + mahFinalCartTotal.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        child: SingleChildScrollView(
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
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (qur) => {
                                      //print(qur),
                                      firestore.collection('coupon').doc(qur.toString()).get().then((value) => {
                                            applyCoupon(value.data()),
                                            _coupnRemark = value.data(),
                                          })
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.card_giftcard_sharp),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      coupMark.toString(),
                                      style: TextStyle(color: Colors.green, fontSize: 12),
                                    ),
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 15,
                                    )
                                  ],
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Product ',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                                Text(
                                  "₹${mahCartTotal.toString()}",
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.4,
                            color: Colors.black45,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Coupon',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              isap
                                  ? Text(
                                      _coupnRemark != null ? _coupnRemark['dic'].toString() : "N.A.",
                                      style: TextStyle(color: Colors.black, fontSize: 18),
                                    )
                                  : Text("N.A."),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black87,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total ',
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              Text(
                                "₹${mahFinalCartTotal.toString()}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
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
                  child: mahFinalCartTotal > 240
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (ordBtn == 0) {
                                ordBtn = 1;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: <Widget>[
                                        Text("Submitting Order"),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                    duration: Duration(seconds: 3),
                                  ),
                                );
                                var currDt = DateTime.now();
                                int curTime = currDt.millisecondsSinceEpoch;
                                cMap['oCus'] = auth.currentUser!.uid;
                                cMap['oCoup'] = _coupnRemark != null ? _coupnRemark['dic'] : "none";
                                cMap['oCD'] = _coupnRemark != null ? _coupnRemark['dic'] : 0;
                                cMap['oAdr'] = cus['adr'];
                                cMap['oFRate'] = mahFinalCartTotal;
                                cMap['oTime'] = curTime;
                                cMap['status'] = 'ordered';
                                cMap['order'] = mahCartDetail;
                                cMap['sOrd'] = myCartInst;
                                cMap['oRate'] = mahCartTotal;
                                cMap['cartSize'] = cartItm;
                                cMap['cartType'] = 'wsl';

                                //print(mahCartDetail);
                                for (int i = 0; i < mahCartDetail.length; i++) {
                                  //print(mahCartDetail[i.toString()]['pSize']);
                                }
                                //print(mahCartDetail.keys);

                                CollectionReference users = FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(auth.currentUser!.uid)
                                    .collection('order');

                                // Call the user's CollectionReference to add a new user
                                users.doc(currDt.millisecondsSinceEpoch.toString()).set(cMap).whenComplete(() => {
                                      if (_coupnRemark != null)
                                        {
                                          firestore.collection('coupon').doc(_coupnRemark['name']).update({
                                            'leng': FieldValue.increment(-1),
                                            'count': FieldValue.increment(1),
                                          }).then((value) => {
                                                updateProdDoc(),
                                                firestore
                                                    .collection("orders")
                                                    .doc('orders')
                                                    .collection(currDt.month.toString() + currDt.year.toString())
                                                    .add(cMap)
                                                    .whenComplete(() {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => CartConfirmdScreen(
                                                                oId: currDt.millisecondsSinceEpoch,
                                                              )));
                                                })
                                              })
                                        }
                                      else
                                        {
                                          updateProdDoc(),
                                          firestore
                                              .collection("orders")
                                              .doc('orders')
                                              .collection(currDt.month.toString() + currDt.year.toString())
                                              .add(cMap)
                                              .whenComplete(() {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => CartConfirmdScreen(
                                                        oId: currDt.millisecondsSinceEpoch,
                                                      )),
                                            );
                                          })
                                        },
                                    });

                                /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartConfirmd(img: mahCartImage)),
                      );*/
                              } else {
                                print(ordBtn);
                                print(intCon);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Text(
                                  "CONFIRM ORDER",
                                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Text('Order Should Be greater than ₹240'),
                        )),
            ],
          ),
        ),
      ),
    );
  }

}


updateProdDoc() {
  for (int i = 0; i < myCartInst.length; i++) {
    //print(myCartInst.length.toString());
    //print(myCartInst.keys.toList()[i]);

    if (myCartInst[myCartInst.keys.toList()[i]] != 'pQnt') {
      firestore.collection('Store').doc('ITEM').collection('itms').doc(myCartInst.keys.toList()[i]).update({
        myCartInst[myCartInst.keys.toList()[i]]: FieldValue.increment(-1),
      });
    } else {
      firestore.collection('Store').doc('ITEM').collection('itms').doc(myCartInst.keys.toList()[i]).update({
        'pQnt': FieldValue.increment(-1),
      });
    }
  }
}
