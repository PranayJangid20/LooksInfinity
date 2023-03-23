import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/account/presentation/my_wishlist_screen.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
import 'package:lookinfinity/featues/authentication/presentation/login_screen.dart';
import 'package:lookinfinity/common/user.dart';
import 'package:lookinfinity/common/widget/window.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;

FirebaseAuth auth = FirebaseAuth.instance;

class CategoryActivity extends StatefulWidget {
  var catg;

  CategoryActivity({@required this.catg});
  @override
  _CategoryActivityState createState() => _CategoryActivityState();
}

class _CategoryActivityState extends State<CategoryActivity> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        toolbarHeight: 50,
        backgroundColor:AppConstant.APPBAR_BACKGROUND_COLOR,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },
          icon: const Icon(Icons.arrow_back_rounded,color: Colors.white,size: 30,),
        ),
        title: Image.asset('Assets/images/Infi.png',height: 40,),
        centerTitle: true,
        /*leading: Icon(
            Icons.sort,
            size: MediaQuery.of(context).size.width/12,
            color: Colors.black,
          ),*/
        actions: [

          GestureDetector(onTap: (){
            if(auth != null)
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWishList()));
            }
            else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset('Assets/images/favBagSW.png',),
              )),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: firestore.collection('Store').doc('ITEM').collection('itms').where('pCatg',isEqualTo: widget.catg).get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            print(snapshot.data.docs.length);
          }
          return snapshot.hasData ? GridView.builder(
            itemCount: snapshot.data.docs.length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                childAspectRatio: ((screenSize.width / 2.35) /
                    (MediaQuery
                        .of(context)
                        .size
                        .width * 0.700))),
            itemBuilder: (BuildContext context, int index) {

              //var indx = widget.qur[index];

              //print(indx);

              return GestureDetector(onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(prod: snapshot.data.docs[index].data()['pId'],)));
              },
                  child: Window(
                    id: snapshot.data.docs[index].data(),));
            },
          ):CircularProgressIndicator();
        },),

    );
  }
}
