import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
import 'package:lookinfinity/common/widget/trend_windows.dart';
import 'package:lookinfinity/common/widget/window.dart';

class TreandWomen extends StatefulWidget {
  final trdWmn;

  const TreandWomen({super.key, @required this.trdWmn});
  @override
  _TreandWomenState createState() => _TreandWomenState();
}

var map = [];

class _TreandWomenState extends State<TreandWomen> {
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.trdWmn.length; i++) {
      if (dataSet != null) {
        for (int j = 0; j < dataSet.docs.length; j++) {
          if (widget.trdWmn[i] == dataSet.docs[j].data()['pId']) {
            print(widget.trdWmn[i] + ' - ' + dataSet.docs[j].data()['pId']);
            map.add(dataSet.docs[j].data());
            print('//////////');
            print(dataSet.docs[3].data());
            print('//////////');
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
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
                        text: "WOMEN",
                        style: TextStyle(
                          color: Colors.pinkAccent,
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
