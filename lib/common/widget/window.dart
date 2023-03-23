import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lookinfinity/common/app_constant.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';
class Window extends StatefulWidget {
final Map id;

const Window({super.key, required  this.id});
  @override
  _WindowState createState() => _WindowState();
}

class _WindowState extends State<Window> {

  late String image, name, rate;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: (MediaQuery.of(context).size.width*45)/100,
      height: (MediaQuery.of(context).size.height*45)/100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Container(
          decoration: const BoxDecoration(
            color: AppConstant.WINDOW_BG_COLOR,
              boxShadow: [BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
              ),]
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Image.network(
                  widget.id["pImg"][0],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Expanded(

                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  width: double.infinity,
                  child: Container(

                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.id["pName"].toString().toUpperCase(),
                                  style: GoogleFonts.poppins(fontSize: 15,letterSpacing: -0.5,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    //saleMap['actv']? '₹'+ (widget.info-saleMap[widget.catg]).toString():'₹'+ widget.info.toString()
                                  saleMap['actv']? "₹${widget.id["pRate"]-saleMap[widget.id["pCatg"]]}":"₹${widget.id["pRate"]}",
                                  style: const TextStyle(
                                      fontSize: 17,fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 4,child: Text('${widget.id["pDiff"]}%',style: GoogleFonts.bigShouldersDisplay(color: AppConstant.OFF_COLOR,fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.center,))
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
