import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/checkout/presentation/payment_screen.dart';
class AddressConfirmScreen extends StatefulWidget {
  @override
  _AddressConfirmScreenState createState() => _AddressConfirmScreenState();
}

class _AddressConfirmScreenState extends State<AddressConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    var check = 2;
    return check == 1?Expanded(
      child: Container(
        color: AppConstant.CHECKOUT_BG_COLOR,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: AppConstant.CHECKOUT_BG_COLOR,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text("Address",style: TextStyle(fontSize: 35,color: Colors.black),),
                    Divider(thickness: 2,color: Colors.black26,),
                    Text("Some where in some where,near landmark,landmark,area,jodhpur,Rajsthan, India",
                      style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                check=2;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    child: Text("Next",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ):Payment_Screen();

  }
}
