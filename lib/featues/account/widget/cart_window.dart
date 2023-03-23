
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/featues/checkout/presentation/confirmed_screen.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
import 'package:lookinfinity/uttils/cusInfom.dart';

import '../../checkout/presentation/cart_confirmed_screen.dart';

class CartWindow extends StatefulWidget {
  var cartData;
  CartWindow({@required this.cartData});
  @override
  _CartWindowState createState() => _CartWindowState();
}

class _CartWindowState extends State<CartWindow> {
  @override
  Widget build(BuildContext context) {
    double hSize(double Percentage) {
      return (MediaQuery.of(context).size.height * Percentage) / 100;
    }

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ConfirmedScreen(oId:widget.cartData['oTime'])));
      },

      child: Container(
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
                widget.cartData['oImg'],
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
                          widget.cartData['oName'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Taviraj"),
                        ),
                        Text(
                          widget.cartData['oSdec'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          widget.cartData['status'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Text(
                    '₹' + widget.cartData['oFRate'].toString(),
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
      ),
    );
  }
}


class MultCartWindow extends StatefulWidget {
  var cartData;
  MultCartWindow({@required this.cartData});
  @override
  _MultCartWindowState createState() => _MultCartWindowState();
}

class _MultCartWindowState extends State<MultCartWindow> {
  @override
  Widget build(BuildContext context) {
    double hSize(double Percentage) {
      return (MediaQuery.of(context).size.height * Percentage) / 100;
    }

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartConfirmdScreen(oId:widget.cartData['oTime'])));
      },
      child: Container(
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
                widget.cartData['order']['0']['pImg'][0],
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
                          widget.cartData['order']['0']['pName'].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Taviraj"),
                        ),
                        Text(
                          'ITEMS : '+widget.cartData['order'].length.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          widget.cartData['status'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    '₹' + widget.cartData['oFRate'].toString(),
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
      ),
    );
  }
}


class CartView extends StatefulWidget {
  var cartData;

  CartView({super.key, @required this.cartData});
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  Color box = Colors.grey.shade200;
  Color text = Colors.black;
  Color sbox = Colors.black;
  Color stext = Colors.white;
  Color dbox = Colors.transparent;
  Color dtext = Colors.black;
  int ind = 0;

  var CselSize = 0;
  var showSize = [];

  @override
  Widget build(BuildContext context) {
    double size(@required int Percent) {
      return ((MediaQuery.of(context).size.height * Percent) / 100);
    }

    List calSize() {
      showSize = [];
      print(widget.cartData['pId']);
      widget.cartData['pSize'].forEach((element) {
        if (widget.cartData[element] > 0) {
          showSize.add(element);
        }
      });

      return showSize;
    }

    print('--' + calSize().toString());

    if (myOrderCart[widget.cartData['pId']] == null) {
      myOrderCart[widget.cartData['pId']] = showSize[0];
    }

    if (showSize.length < 1) {
      myOrderCart.remove(widget.cartData['pId']);
    }

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(prod: widget.cartData['pId']))),
      child: Container(
        padding: EdgeInsets.only(
          bottom: 10,
          top: 5,
        ),
        margin: EdgeInsets.only(top: 5),
        height: size(15),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            )),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.network(
                widget.cartData['pImg'][0],
                height: size(12),
              ),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  height: double.infinity,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.cartData['pName'],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Taviraj"),
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
                        child: showSize.length != 0
                            ? showSize[0] != 'pQnt' && showSize != []
                            ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: showSize.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      ind = index;
                                      CselSize = index;
                                      myOrderCart[
                                      widget.cartData['pId']] =
                                      showSize[index];
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: index == CselSize
                                          ? Colors.black
                                          : box,
                                      borderRadius:
                                      BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 2,
                                            horizontal: 2),
                                        child: Text(
                                          showSize[index],
                                          style: GoogleFonts.lato(
                                              color: index == CselSize
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                            : Container()
                            : Text(
                          'Not Available',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                child: Text(
                  saleMap[widget.cartData['pCatg']] != 0 && saleMap['actv']
                      ? '₹' +
                      (widget.cartData['pRate'] -
                          saleMap[widget.cartData['pCatg']])
                          .toString()
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
