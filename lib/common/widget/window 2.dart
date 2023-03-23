import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Window2 extends StatefulWidget {
  final Map id;
  const Window2({required  this.id});
  @override
  _Window2State createState() => _Window2State();
}


class _Window2State extends State<Window2> {

  late String image;
  late String name;
  late String rate;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: (MediaQuery.of(context).size.width*45)/100,
      height: (MediaQuery.of(context).size.height*45)/100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xFFDFDEEE),//DEEEDF//F5F5F5
              boxShadow: [BoxShadow(
                color: Colors.black,
                blurRadius: 2.0,
              ),]
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.network(
                      widget.id["pImg"][0],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
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
                                  widget.id["pName"],
                                  style: GoogleFonts.poppins(fontSize: 16,letterSpacing: -0.5,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "₹${widget.id["pRate"]}",
                                  style: const TextStyle(
                                      fontSize: 17,fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(flex: 4,child: Text("35%",style: TextStyle(color: Colors.orangeAccent,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,))
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