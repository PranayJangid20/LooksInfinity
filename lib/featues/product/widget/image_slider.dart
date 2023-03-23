import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/checkout/presentation/checkout_screen.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/authentication/presentation/login_screen.dart';
import 'package:lookinfinity/common/user.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';

class ImageCouView extends StatefulWidget {
  final List<dynamic> pImg;
  final double height;
  const ImageCouView({required this.pImg, required this.height});
  @override
  _ImageCouViewState createState() => _ImageCouViewState();
}

int curIm = 0;

class _ImageCouViewState extends State<ImageCouView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> CaroItm = [];
    for (int i = 0; i < widget.pImg.length; i++) {
      CaroItm.add(Container(
        child: InteractiveViewer(
          child: Image(
            image: NetworkImage(widget.pImg[i].toString()),
            fit: BoxFit.fitWidth,
          ),
        ),
      ));
    }
    return CarouselSlider(
      items: CaroItm,
      options: CarouselOptions(height: widget.height, viewportFraction: 1.0),
    );
    /*return GestureDetector(
      onHorizontalDragEnd: (dtl){
        if(dtl.velocity.pixelsPerSecond.dx>0){
          setState(() {

            curIm++;
            if(curIm<widget.pImg.length){
              curIm = 0;
            }
            print("Right Swap"  + curIm.toString());
            print( widget.pImg[curIm].toString());
          });
        }
        else{
            setState(() {

              curIm--;
              if(curIm<0){
                curIm = widget.pImg.length-1;
              }
              print("Left Swap" + curIm.toString());
              print( widget.pImg[curIm].toString());
            });
        }
      },
      child: InteractiveViewer(
        child: Image(
          image: NetworkImage(
              widget.pImg[curIm].toString()),
          height: widget.height,
          fit: BoxFit.cover,
        ),
      ),
    );*/
  }
}

class ActionBtns extends StatefulWidget {
  String prod;
  var info;
  String catg;
  ActionBtns({Key ?key, required this.prod, required this.info, required this.catg}) : super(key: key);
  @override
  _ActionBtnsState createState() => _ActionBtnsState();
}

class _ActionBtnsState extends State<ActionBtns> {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Container(
        padding: EdgeInsets.all(10),
        height: 70, //size(8.5),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppConstant.ACTION_BG_COLOR,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              saleMap['actv']? '₹${widget.info-saleMap[widget.catg]}':'₹${widget.info}',
              style: GoogleFonts.archivo(
                color: Colors.white,
                fontSize: 30, //size(3.79),
                letterSpacing: 1.7,
                fontWeight: FontWeight.w900,
                shadows: [
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.black38,
                    offset: Offset(3.0, 5.0),
                  ),
                ],
              ),
            ),
            //if(userId != null){}
            Container(
              width: 250,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          mInfo = snapshot.data!.data();
                        }
                        return snapshot.hasData
                            ? GestureDetector(
                          onTap: () {
                            //print(cltCart);
                            setState(() {
                              FirebaseFirestore.instance
                                  .collection("user")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "whl": snapshot.data!
                                    .data()!['whl']
                                    .contains(widget.prod)
                                    ? FieldValue.arrayRemove(
                                    [widget.prod])
                                    : FieldValue.arrayUnion([widget.prod])
                              });
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "ADD CART",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                snapshot.data!
                                    .data()!['whl']
                                    .contains(widget.prod)
                                    ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                )
                                    : Icon(
                                  Icons.favorite,
                                  color: Colors.grey.shade400,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                        )
                            : CircularProgressIndicator();
                      }),
                  fSize.isNotEmpty && widget.info >240?
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutScreen(pid: widget.prod,size: selSize ?? fSize[0],)),
                      );
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "BUY NOW",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  )
                      :Container(),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        height: 70, //size(8.5),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppConstant.ACTION_BG_COLOR,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              saleMap['actv']? '₹${widget.info-saleMap[widget.catg]}':'₹${widget.info}',
              style: GoogleFonts.archivo(
                color: Colors.white,
                fontSize: 35, //size(3.79),
                letterSpacing: 1.7,
                fontWeight: FontWeight.w900,
                shadows: [
                  const Shadow(
                    blurRadius: 10.0,
                    color: Colors.black38,
                    offset: Offset(3.0, 5.0),
                  ),
                ],
              ),
            ),
            Container(
              width: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "SIGN IN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

class RwsPannel extends StatefulWidget {
  var snap;
  var sze;
  RwsPannel({@required this.snap, @required this.sze});
  @override
  _RwsPannelState createState() => _RwsPannelState();
}

class _RwsPannelState extends State<RwsPannel> {
  @override
  Widget build(BuildContext context) {
    bool isRv = false;
    //print(authState);
    if(authState==true){
      for(int i=0;i<widget.snap.data.docs.length;i++){
        //print(widget.snap.data.docs[i].data()["cId"]);
        if(widget.snap.data.docs[i].data()["cId"] == FirebaseAuth.instance.currentUser!.uid){
          isRv = true;
          break;
        }
      }
    }

    //print(isRv);
    return Container(

      height: widget.sze,
      child: Column(
        children: [
          Text("Reviews", style: GoogleFonts.bellefair(fontSize: 28,fontWeight: FontWeight.w400),),
          Divider(color: Colors.black45,),
          Expanded(
            child: ListView.builder(
                itemCount: widget.snap.data.docs.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5, color: Colors.black),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.account_box,color: Colors.grey,),
                                    Text(widget.snap.data.docs[index].data()["cName"],style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text(widget.snap.data.docs[index].data()["cRw"],style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,)),
                              ],
                            ),
                            Row(children: [
                              Icon(Icons.star_outline_sharp,color: Colors.green,),
                              Text(widget.snap.data.docs[index].data()["cRt"].toString(),style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),),
                            ],)
                          ],
                        )),
                  );
                }
            ),
          ),
          !isRv && authState?
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (_) {
                    return RwsAlert();

                  });
            },
            color: Colors.orangeAccent,
            child: Text("Post Review"),
          )
              :Container()
        ],
      ),
    );
  }
}


class RateReviewWidget extends StatefulWidget {
  const RateReviewWidget({Key ?key}) : super(key: key);

  @override
  State<RateReviewWidget> createState() => _RateReviewWidgetState();
}

class _RateReviewWidgetState extends State<RateReviewWidget> {

  double _currentSliderValue = 1;

  var _rwsText;

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.orangeAccent,
      inactiveColor: Colors.amberAccent,
      value: _currentSliderValue,
      min: 1,
      max: 5,
      divisions: 4,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
          //print(_currentSliderValue);
        });
      },
    );
  }
}

class RwsAlert extends StatefulWidget {
  @override
  _RwsAlertState createState() => _RwsAlertState();
}

class _RwsAlertState extends State<RwsAlert> {
  double _currentSliderValue = 1;

  var _rwsText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      title: Text('Review',style: TextStyle(color: Colors.white),),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Rate Product',style: TextStyle(color: Colors.white),),
            RateReviewWidget(),

            Text('Write ',style: TextStyle(color: Colors.white),),
            TextField(
              onChanged: (t){
                _rwsText = t;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0),
                    borderRadius: BorderRadius.circular(10)
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              maxLines: 3,
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancle'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Post',style: TextStyle(color:Color(0XFFFAC157)),),
          onPressed: () {
            var dt = DateTime.now();
            FirebaseFirestore.instance
                .collection("Store")
                .doc("ITEM")
                .collection("itms")
                .doc(prdId).collection('rws').add({"cName": mInfo['name'],'cRt':_currentSliderValue,'cRw':_rwsText,'pTime':dt.millisecondsSinceEpoch,'cId':FirebaseAuth.instance.currentUser!.uid})
                .whenComplete(() {Navigator.of(context).pop();});
          },
        ),
      ],
    );
  }
}
