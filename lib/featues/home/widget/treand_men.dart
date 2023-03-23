import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/common/widget/trend_windows.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
import '../../../common/widget/window.dart';

class TreandMen extends StatefulWidget {
  final trdMen;

  const TreandMen({super.key, @required this.trdMen});

  @override
  _TreandMenState createState() => _TreandMenState();
}

var map = [];

class _TreandMenState extends State<TreandMen> {
  /*void fetchTrd(){
    for(int i =0; i<dataSet.docs.length; i++){
      if(widget.trdMen.contains(dataSet.docs[i])){
        map.add(dataSet.docs[i].data());
      }
    }
  }*/
  @override
  Widget build(BuildContext context) {
    /*fetchTrd();
    print(map);*/
    if (dataSet != null) {
      for (int i = 0; i < widget.trdMen.length; i++) {
        for (int j = 0; j < dataSet.docs.length; j++) {
          if (widget.trdMen[i] == dataSet.docs[j].data()['pId']) {
            print(widget.trdMen[i] + ' - ' + dataSet.docs[j].data()['pId']);
            map.add(dataSet.docs[j].data());
          }
        }
      }
    }

    return map.isEmpty
        ? Container()
        : Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 2),
                  width: double.infinity,
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: "TRENDING--",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    TextSpan(
                        text: "MEN",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                        ))
                  ])),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TrendWindow(
                      name: map[0]['pName'],
                      rate: map[0]['pRate'].toString(),
                      image: map[0]['pImg'][0],
                      pId: map[0]['pId'],
                      dict: "${map[0]['pDiff']}%",
                    ),
                    TrendWindow(
                      name: map[1]['pName'],
                      rate: map[1]['pRate'].toString(),
                      image: map[1]['pImg'][0],
                      pId: map[1]['pId'],
                      dict: "${map[1]['pDiff']}%",
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TrendWindow(
                      name: map[2]['pName'],
                      rate: map[2]['pRate'].toString(),
                      image: map[2]['pImg'][0],
                      pId: map[2]['pId'],
                      dict: "${map[2]['pDiff']}%",
                    ),
                    TrendWindow(
                      name: map[3]['pName'],
                      rate: map[3]['pRate'].toString(),
                      image: map[3]['pImg'][0],
                      pId: map[3]['pId'],
                      dict: "${map[3]['pDiff']}%",
                    )
                  ],
                ),
              ],
            ),
          );
  }
}

/*
class WindowTreandMan extends StatefulWidget {
  final String image;
  final String name;
  final String rate;
  final String dict;
  final String pId;
  const WindowTreandMan({super.key, required this.image, required this.name, required this.rate, required this.dict, required this.pId});

  @override
  _WindowTreandManState createState() => _WindowTreandManState();
}

class _WindowTreandManState extends State<WindowTreandMan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 45) / 100,
      height: (MediaQuery.of(context).size.height * 45) / 100,
      padding: const EdgeInsets.all(0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      prod: widget.pId.toString(),
                    )),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  //padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    color: Color(0X15C9AA6A),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name.toUpperCase(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, letterSpacing: -0.5, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "₹" + widget.rate,
                                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: Text(
                              widget.dict,
                              style: GoogleFonts.bigShouldersDisplay(
                                  color: AppConstant.OFF_COLOR, fontWeight: FontWeight.bold, fontSize: 25),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
