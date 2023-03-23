
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/uttils/cusInfom.dart';
import 'package:lottie/lottie.dart';

import '../widgets/checkout_image_view.dart';


FirebaseAuth auth = FirebaseAuth.instance;

FirebaseFirestore firestore = FirebaseFirestore.instance;

var oImg = [];

class CartConfirmdScreen extends StatefulWidget {
  final oId;
  const CartConfirmdScreen({super.key, @required this.oId,});
  @override
  _CartConfirmdScreenState createState() => _CartConfirmdScreenState();
}

class _CartConfirmdScreenState extends State<CartConfirmdScreen> {
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }
  @override
  Widget build(BuildContext context) {

    double hSize(double Percentage) {
      return (MediaQuery.of(context).size.height * Percentage) / 100;
    }
    return SafeArea(
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
              print(pOrder);

              print(pOrder.length);
              
              for(int i = 0; i<pOrder['order'].length;i++){
                oImg.add(pOrder['order'][i.toString()]['pImg'][0]);
              }
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
                        color: AppConstant.BACKGROUND_COLOR,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [ BoxShadow(
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
                              child: Column(
                                children: [
                                 CheckoutImagesView(
                                   height: hSize(30),
                                   pImg: oImg,
                                   oData: pOrder['order'],
                                 )
                                ],
                              ),
                            ),

                          ],
                        ),


                        Column(
                          children: [

                            Lottie.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_X4ChUw.json',height: 150),
                            pOrder['status'] != 'canceled' ?
                            Text('${pOrder['status'].toString().toUpperCase()} SUCCESSFUL',style: const TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.bold),)
                            :const Text('CANCELED',style: TextStyle(color: Colors.red,fontSize: 25,fontWeight: FontWeight.bold),),
            Divider(thickness: 1,color: Colors.black,)
                          ],
                        ),
                        Column(
                          children: const [
                            Text("BILLING DETAIL-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 50),
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
                              const Text('Total Items',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text(pOrder['cartSize'].toString(),style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Order Total',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹${pOrder['oRate']}',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Coupon',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹${pOrder['oCD']}',style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
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
                        const SizedBox(height: 1,child: Divider(thickness: 0.5,color: Colors.black,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,),
                              Text('₹${pOrder['oFRate']}',style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black) ,)
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
                : const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
