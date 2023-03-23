import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';

class TrendWindow extends StatefulWidget {
  final String image;
  final String name;
  final String rate;
  final String dict;
  final String pId;
  const TrendWindow({required this.image,required this.name,required this.rate,required this.dict,required this.pId});

  @override
  _TrendWindowState createState() => _TrendWindowState();
}
class _TrendWindowState extends State<TrendWindow> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: (MediaQuery.of(context).size.width*45)/100,
      height: (MediaQuery.of(context).size.height*45)/100,
      padding: const EdgeInsets.all(0.0),

      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDetailScreen(prod: widget.pId,)),
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
                                  style: GoogleFonts.poppins(fontSize: 16,letterSpacing: -0.5,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "₹"+widget.rate,
                                  style: TextStyle(
                                      fontSize: 18,fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 4,child: Text(widget.dict,style: GoogleFonts.bigShouldersDisplay(color: AppConstant.OFF_COLOR,fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,))
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
