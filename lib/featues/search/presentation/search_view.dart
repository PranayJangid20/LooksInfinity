import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
import 'package:lookinfinity/featues/authentication/presentation/login_screen.dart';
import 'package:lookinfinity/common/user.dart';
import 'package:lookinfinity/common/widget/window%202.dart';
import 'package:lookinfinity/common/widget/window.dart';
import 'dart:convert';
import '../../account/presentation/my_wishlist_screen.dart';
import '../../../uttils/logic_data.dart';


FirebaseAuth auth = FirebaseAuth.instance;

class SearchView extends StatefulWidget {
  List qur;
  SearchView({Key ?key, required this.qur}) : super(key: key);
  @override

  _SearchViewState createState() => _SearchViewState();
}


class _SearchViewState extends State<SearchView> {
  var _priceFilter = "999999";
  var _sortFilter = "diff";
  var _rcdFilter = "Casual";



  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override

  Widget build(BuildContext context) {


    double hSize(double Percentage) {
      return (MediaQuery.of(context).size.height * Percentage) / 100;
    }

    double wSize(double Percentage) {
      return (MediaQuery.of(context).size.width * Percentage) / 100;
    }

    var screenSize = MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          toolbarHeight: 50,
          backgroundColor:AppConstant.APPBAR_BACKGROUND_COLOR,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          },
            icon: Icon(Icons.arrow_back_rounded,color: Colors.white,size: 30,),
          ),
          title: Image.asset('Assets/images/Infi.png',height: 50,),
          centerTitle: true,
          /*leading: Icon(
            Icons.sort,
            size: MediaQuery.of(context).size.width/12,
            color: Colors.black,
          ),*/
          actions: [

            GestureDetector(onTap: (){
              if(authUser != null)
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
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          backgroundColor: AppConstant.ACTION_BG_COLOR,
          child: Icon(Icons.filter_list,color: Colors.white,),

        ),*/
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //Text(List.qur,style: TextStyle(color: Colors.black),),
            /*Container(
              width: double.infinity,
              color:APPBAR_BACKGROUND_COLOR,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: false,

                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black87,
                      icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 25,),
                      value: _priceFilter,
                      items: [
                        DropdownMenuItem(child: Text('Under 250'),value: '250',),
                        DropdownMenuItem(child: Text('Under 500'),value: '500',),
                        DropdownMenuItem(child: Text('Under 1000'),value: '1000',),
                        DropdownMenuItem(child: Text('All Pricing'),value: '999999',),
                      ],
                      onChanged: (value){
                        setState(() {
                          _priceFilter = value;
                        });
                      },),
                  ),

                 *//* DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: false,
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black87,
                      icon: Icon(Icons.swap_vert,color: Colors.white,size: 25,),
                      value: _sortFilter,
                      items: [
                        DropdownMenuItem(child: Text('Order By Discount'),value: "diff",),
                        DropdownMenuItem(child: Text('Order By Price'),value: 'pRate',),
                        DropdownMenuItem(child: Text('Order By Latest'),value: 'pTime',),
                      ],
                      onChanged: (value){
                        setState(() {
                          _sortFilter = value;
                        });
                      },),
                  ),

                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: false,
                      style: TextStyle(color: Colors.white),
                      dropdownColor: Colors.black87,
                      icon: Icon(Icons.swap_vert,color: Colors.white,size: 25,),
                      value: _rcdFilter,
                      items: [
                        DropdownMenuItem(child: Text('Casual'),value: 'Casual',),
                        DropdownMenuItem(child: Text('Party'),value: 'Party',),
                        DropdownMenuItem(child: Text('Formal'),value: 'Formal',),
                        DropdownMenuItem(child: Text('Wedding'),value: 'Wedding',),
                      ],
                      onChanged: (value){
                        setState(() {
                          _rcdFilter = value;
                        });
                      },),
                  ),*//*
                ],
              ),
            ),*/
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                  child:

                  StreamBuilder(
                      stream: firestore.collection("Store").doc("ITEM").collection("itms").where("pRate",isLessThan: _priceFilter).snapshots(),
                      builder: (context, snapshot) {

                        return GridView.builder(
                          itemCount: widget.qur.length,
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

                            var indx = widget.qur[index];

                            //print(indx);

                            return GestureDetector(onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailScreen(prod: dataSet.docs[indx].data()["pId"],)));
                            },
                                child: Window(
                                  id: dataSet.docs[indx].data(),));
                          },
                        );
                      }
                  )




              ),
            ),
          ],
        ),
      ),
    );
  }
}

//((screenSize.width/1.85)/(MediaQuery.of(context).size.width*0.735))

class FilterBar extends StatefulWidget {

  @override
  _FilterBarState createState() => _FilterBarState();
}


class _FilterBarState extends State<FilterBar> {
  var _priceFilter = "All";
  var _sortFilter = "New Arrivals";
  var _rcdFilter = "All";
  var _aFSize = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color:AppConstant.APPBAR_BACKGROUND_COLOR,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: false,

                  style: TextStyle(color: Colors.white),
                  dropdownColor: Colors.black87,
                  icon: Icon(Icons.keyboard_arrow_down,color: Colors.white,size: 25,),
                  value: _priceFilter,
                  items: [
                    DropdownMenuItem(child: Text('Under 250'),value: 'Under 250',),
                    DropdownMenuItem(child: Text('Under 500'),value: 'Under 500',),
                    DropdownMenuItem(child: Text('Under 1000'),value: 'Under 1000',),
                    DropdownMenuItem(child: Text('Above 1000'),value: 'Above 1000',),
                    DropdownMenuItem(child: Text('All Pricing'),value: 'All',),
                  ],
                  onChanged: (value){
                    setState(() {
                      _aFSize = 30.0;
                      _priceFilter = value!;
                    });
                  },),
              ),

              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: false,
                  style: TextStyle(color: Colors.white),
                  dropdownColor: Colors.black87,
                  icon: Icon(Icons.swap_vert,color: Colors.white,size: 25,),
                  value: _sortFilter,
                  items: [
                    DropdownMenuItem(child: Text('High To Low'),value: 'High To Low',),
                    DropdownMenuItem(child: Text('Low To High'),value: 'Low To High',),
                    DropdownMenuItem(child: Text('New Arrivals'),value: 'New Arrivals',),
                  ],
                  onChanged: (value){
                    setState(() {
                      _aFSize = 30.0;
                      _sortFilter = value!;
                    });
                  },),
              ),

              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: false,
                  style: TextStyle(color: Colors.white),
                  dropdownColor: Colors.black87,
                  icon: Icon(Icons.swap_vert,color: Colors.white,size: 25,),
                  value: _rcdFilter,
                  items: [
                    DropdownMenuItem(child: Text('Casual'),value: 'Casual',),
                    DropdownMenuItem(child: Text('Party'),value: 'Party',),
                    DropdownMenuItem(child: Text('Formal'),value: 'Formal',),
                    DropdownMenuItem(child: Text('Wedding'),value: 'Wedding',),
                    DropdownMenuItem(child: Text('Type Filter'),value: 'All',),
                  ],
                  onChanged: (value){
                    setState(() {
                      _aFSize = 30.0;
                      _rcdFilter = value!;
                    });
                  },),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.orange,
          width: double.infinity,
          height: _aFSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Apply Filter",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              MaterialButton(
                onPressed: (){

                  setState(() {

                    _aFSize = 0.0;
                  });
                },
                child: Text("Refresh",style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        )
      ],
    );
  }
}
