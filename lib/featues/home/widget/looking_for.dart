import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lookinfinity/featues/account/widget/category_activity.dart';
class Looking extends StatefulWidget {
  @override
  _LookingState createState() => _LookingState();
}

class _LookingState extends State<Looking> {
  @override
  Widget build(BuildContext context) {
    double height(@required int Percent)
    {
      return ((MediaQuery.of(context).size.height * Percent)/100);
    }

    double width(@required int Percent)
    {
      return ((MediaQuery.of(context).size.width * Percent)/100);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
       Expanded(
         child: GestureDetector(
           onTap: (){
             Navigator.of(context).push(MaterialPageRoute(
                 builder: (context) => CategoryActivity(catg: 'MEN')));
           },
           child: Container(
             width: width(18),
             height: width(18),
             decoration: BoxDecoration(
               color: Colors.transparent,
               borderRadius: BorderRadius.circular(10)
             ),
             padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
             child: Image.asset("Assets/images/catgMan.png")
           ),
         ),
       ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryActivity(catg: 'WMN')));
            },
            child: Container(
              width: width(18),
              height: width(18),
             decoration: BoxDecoration(
               color: Colors.transparent,
               borderRadius: BorderRadius.circular(10)
             ),
             padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
             child: Image.asset("Assets/images/catgWomen.png"),
       ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
       //  Expanded(
       //    child: Container(
       //
       //      width: width(18),
       //      height: width(18),
       //     decoration: BoxDecoration(
       //       color: Colors.white,
       //       borderRadius: BorderRadius.circular(10)
       //     ),
       //     padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
       //     child: Image.asset("Assets/images/catgMan.png"),
       // ),
       //  ),
       //  SizedBox(
       //    width: 10,
       //  ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryActivity(catg: 'JWL')));
            },
            child: Container(
              width: width(18),
              height: width(18),
             decoration: BoxDecoration(
               color: Colors.transparent,
               borderRadius: BorderRadius.circular(10)
             ),
             padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
             child: Image.asset("Assets/images/cagArtJwl.png"),
       ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoryActivity(catg: 'DCR')));
            },
            child: Container(
              width: width(15),
              height: width(15),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Image.asset("Assets/images/hdcrd.jpg"),
            ),
          ),
        ),
      ],
    );
  }
}
