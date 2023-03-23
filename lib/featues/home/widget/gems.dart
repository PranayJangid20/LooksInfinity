import 'package:flutter/material.dart';
import 'package:lookinfinity/uttils/logic_data.dart';
import 'package:lookinfinity/featues/product/presentation/product_detail_screen.dart';

class Gems extends StatefulWidget {
  var exl;

  Gems({@required this.exl});
  @override
  _GemsState createState() => _GemsState();
}

var map = [];
class _GemsState extends State<Gems> {
  @override
  Widget build(BuildContext context) {

    for(int i =0;i<widget.exl.length;i++){
      for(int j =0;j<dataSet.docs.length;j++){
        if(widget.exl[i] == dataSet.docs[j].data()['pId'])
        {
          print(widget.exl[i]+' - '+dataSet.docs[j].data()['pId']);
          map.add(dataSet.docs[j].data());
          print(map[i]);
        }
      }
    }

    var width = (MediaQuery.of(context).size.width*20)/100;
    return Container(
      child: Column(
        children: [
          Divider(thickness: 1,color: Colors.amber,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(prod: map[0]["pId"],)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(map[1]['pImg'][0],width: width,),

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(prod: map[1]["pId"],)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(map[1]['pImg'][0],width: width,),

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(prod: map[2]["pId"],)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(map[2]['pImg'][0],width: width,),

                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(prod: map[3]["pId"],)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(map[3]['pImg'][0],width: width,),

                ),
              )
            ],
          ),
          /*SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("https://assets.myntassets.com/f_webp,dpr_1.5,q_60,w_210,c_limit,fl_progressive/assets/images/13460390/2021/1/28/e830d36b-a549-449d-bf85-8aeea4584cd21611809414760-Manyavar-Men-Maroon--Grey-Solid-Kurta-with-Churidar--Nehru-J-1.jpg",width: width,),

              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("https://assets.myntassets.com/f_webp,dpr_1.5,q_60,w_210,c_limit,fl_progressive/assets/images/10275025/2019/9/18/874215f7-ff78-422e-9780-abcdc2a06b6b1568807692873-House-of-Pataudi-Men-Maroon-Solid-A-Line-Kurta-3461568807691-1.jpg",width: width,),

              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("https://assets.myntassets.com/f_webp,dpr_1.5,q_60,w_210,c_limit,fl_progressive/assets/images/14260914/2021/7/2/44bc5c11-7d2e-4185-bf10-62e6f72e8c581625198700383-ice-watch-Men-Black-Bracelet-Style-Straps-Analogue-Watch-167-1.jpg",width: width,),

              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("https://assets.myntassets.com/f_webp,dpr_1.5,q_60,w_210,c_limit,fl_progressive/assets/images/8353645/2019/4/23/015c672e-43ad-4e67-85a4-2cc52ac9530a1556021953748-Roadster-Men-Black-Analogue-Watch-MFB-PN-LB-9323-63515560219-1.jpg",width: width,),

              )
            ],
          ),*/
          Divider(thickness: 1,color: Colors.orangeAccent,),
        ],
      ),
    );
  }
}
