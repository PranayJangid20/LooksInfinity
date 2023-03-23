import 'package:flutter/material.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/checkout/presentation/confirmed_screen.dart';

class Payment_Screen extends StatefulWidget {
  @override
  _Payment_ScreenState createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstant.CHECKOUT_BG_COLOR,
        body: Column(
          children: [
            Expanded(
              flex:5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0XFF9ED6CF),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                    boxShadow: [new BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10.0,
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
                              Image.network("https://assets.myntassets.com/f_webp,dpr_1.5,q_60,w_210,c_limit,fl_progressive/assets/images/11896436/2020/7/22/142128e9-95cd-4471-af6f-e60e24cc03f51595397469617-Sztori-Men-Blue-Solid-Polo-Collar-T-shirt-9731595397467809-1.jpg",
                                height: 120,
                                fit: BoxFit.cover,),
                            ],
                          ),
                        ),

                        Text("Light Blue T-shirt",style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Taviraj"
                        ),),
                        Text("Plane Light Blue Shirt With Color",style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),),
                      ],
                    ),


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
                              child: Text("36",style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text("₹299",style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            letterSpacing: 1.5,
                            fontStyle: FontStyle.italic
                        ),
                        ),
                        Text("TAX INCLUDED",style: TextStyle(color: Colors.black,fontSize: 9),)
                      ],
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: AppConstant.CHECKOUT_BG_COLOR,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(

                          children: [
                            Text("Payment",style: TextStyle(fontSize: 35,color: Colors.black),),
                            Divider(thickness: 2,color: Colors.black26,),
                            Text("PAY ON DELIVERY",style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                            Text("FOR NOW WE ONLY ACCEPT THIS OPTION"
                                "SORRY FOR YOUR INCONVINENCE",
                              style: TextStyle(fontSize: 15,),textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex:6,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black,width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextField(

                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text("APPLY",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ConfirmedScreen()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                            child: Text("CONFIRM ORDER",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
