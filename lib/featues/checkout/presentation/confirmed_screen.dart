import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/uttils/cusInfom.dart';
import 'package:lottie/lottie.dart';

FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class ConfirmedScreen extends StatefulWidget {
  var oId;
  ConfirmedScreen({@required this.oId,});
  @override
  _ConfirmedScreenState createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppConstant.ACTION_BG_COLOR,
        body: FutureBuilder(
          future: firestore.collection('user').doc(auth.currentUser!.uid).collection('order').doc(widget.oId.toString()).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            Map<String, dynamic>? pOrder;
            try {
              pOrder = snapshot.data.data() as Map<
                  String,
                  dynamic>;
            }catch(e){
              print(e);
            }
            return snapshot.hasData &&  pOrder != null? Column(
              children: [
                Expanded(
                  flex:5,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [new BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                        ),]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white54,
                                  boxShadow: [new BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5.0,
                                  ),]
                              ),
                              child: Column(
                                children: [
                                  Image.network(pOrder['oImg'],
                                    height: 120,
                                    fit: BoxFit.cover,),
                                ],
                              ),
                            ),

                            Text(pOrder['oName'],style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Taviraj"
                            ),),
                            /*Text(pOrder['oSdec'],style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),),*/
                          ],
                        ),
                        pOrder['oSize'] != 'pQnt'?
                        Column(
                          children: [
                            Text("SIZE",style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.5,
                                fontFamily: "Taviraj",
                                fontWeight: FontWeight.w600,
                                color: Colors.black87
                            ),),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: 50,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black,width: 1.2,),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(pOrder['oSize'],style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ),
                            ),
                          ],
                        )
                        :Container(),

                        Column(
                          children: [
                            Lottie.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_X4ChUw.json',height: 150),
                            Text("ORDER SUCCESSFUL",style: TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.bold),),
                            Divider(thickness: 1,color: Colors.black,)
                          ],
                        ),
                        Column(
                          children: [
                            Text("BILLING DETAIL-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 50),
                              /*child: Text(cusName+",\n"+cusAddress+",\n"+cusNumber,textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 15
                          ),),*/
                            )

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Total',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹'+pOrder['oRate'].toString(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Coupon',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹'+pOrder['oCD'].toString(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
                            ],
                          ),
                        ),
                        /*Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping Charges',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹20',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
                            ],
                          ),
                        ),*/
                        SizedBox(height: 1,child: Divider(thickness: 0.5,color: Colors.black,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹'+pOrder['oFRate'].toString(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height/100,)

                      ],

                    ),
                  ),
                )
              ],
            )
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
