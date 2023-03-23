import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';

import '../widget/image_slider.dart';

var selSize;

List<String> fSize = [];

var mInfo;

var prdId;

class ProductDetailScreen extends StatefulWidget {
  final String prod;
  const ProductDetailScreen({Key? key, required this.prod}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String cSize;
  var selSize;

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    prdId = widget.prod;
  }

  @override
  Widget build(BuildContext context) {
    double size(double percent) {
      return ((MediaQuery.of(context).size.height * percent) / 100);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: firestore.collection("Store").doc("ITEM").collection("itms").doc(widget.prod).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Map<String, dynamic>? data;
              try {
                data = snapshot.data.data() as Map<String, dynamic>;
                //print(snapshot.data.data());
                fSize = [];
                data['pSize'].forEach((element) {
                  if (data?[element] > 0) {
                    fSize.add(element.toString());
                  }
                });
                //print('Size');
                //print(fSize);
              } catch (e) {
                print(e);
              }
              return snapshot.hasData && data != null
                  ? Column(
                      children: [
                        ImageCouView(
                          height: size(70),
                          pImg: data["pImg"],
                        ),
                        Container(
                          width: double.infinity,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["pName"].toString().toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: size(3.8),
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Taviraj"),
                                      ),
                                      Text(
                                        data["pSdec"],
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: size(1.85),
                                        ),
                                      ),
                                      Divider(
                                        thickness: size(0.3),
                                      ),
                                      Container(
                                        child: fSize.length != 0
                                            ? fSize[0] != "pQnt"
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Text(
                                                          "SIZE",
                                                          style: TextStyle(
                                                              fontSize: size(2.5),
                                                              letterSpacing: 1.5,
                                                              fontFamily: "Taviraj",
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.black87),
                                                        ),
                                                      ),
                                                      Container(
                                                          width: double.infinity,
                                                          height: 70,
                                                          child: SizeCheep(pSize: fSize)),
                                                    ],
                                                  )
                                                : Container()
                                            : const Text(
                                                'Out Of Stock',
                                                style: TextStyle(color: Colors.red),
                                              ),
                                      ),
                                      SizedBox(
                                        height: size(1.9),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2),
                                        child: Text(
                                          "DESCRIPTION",
                                          style: TextStyle(
                                              fontSize: size(2.5), color: Colors.black, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size(2),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: AppConstant.DIVIDER_BLACK_COLOR,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          data["pLdec"],
                                          style:
                                              TextStyle(fontSize: size(2), color: Colors.black87, letterSpacing: 1.1),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size(1),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: AppConstant.DIVIDER_BLACK_COLOR,
                                      ),
                                      FutureBuilder(
                                          future: firestore
                                              .collection("Store")
                                              .doc("ITEM")
                                              .collection("itms")
                                              .doc(data['pId'])
                                              .collection('rws')
                                              .get(),
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            return snapshot.hasData
                                                ? GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return RwsPannel(snap: snapshot, sze: size(80));
                                                          });
                                                    },
                                                    child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(5),
                                                            border: Border.all(color: Colors.black)),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              "View Reviews",
                                                              style: GoogleFonts.robotoMono(fontSize: 18),
                                                            ),
                                                            Text(
                                                              snapshot.data.docs.length.toString(),
                                                              style: GoogleFonts.robotoMono(fontSize: 18),
                                                            ),
                                                          ],
                                                        )),
                                                  )
                                                : CircularProgressIndicator();
                                          }),
                                      SizedBox(
                                        height: 5,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                    child: ActionBtns(prod: widget.prod, info: data['pRate'], catg: data["pCatg"])),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class SizeCheep extends StatefulWidget {
  final List<String> pSize;
  const SizeCheep({
    required this.pSize,
  });

  @override
  _SizeCheepState createState() => _SizeCheepState();
}

class _SizeCheepState extends State<SizeCheep> {
  Color box = Colors.grey.shade200;
  Color text = Colors.black;
  Color sbox = Colors.black;
  Color stext = Colors.white;
  Color dbox = Colors.transparent;
  Color dtext = Colors.black;
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _ProductDetailScreenState().selSize = widget.pSize;
          if (_ProductDetailScreenState().selSize == widget.pSize) {
            box = sbox;
            text = stext;
          }
        });
      },
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.pSize.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    ind = index;
                    //print(widget.pSize[index]);
                    selSize = widget.pSize[index];
                  });
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: index == ind ? Colors.black : box,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      child: Text(
                        widget.pSize[index],
                        style: GoogleFonts.lato(
                            color: index == ind ? Colors.white : text, fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
