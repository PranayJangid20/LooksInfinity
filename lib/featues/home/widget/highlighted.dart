import 'package:flutter/material.dart';
import 'package:lookinfinity/uttils/logic_data.dart';

class Highlighted extends StatefulWidget {
  final String imageOne;
  final String searchOne;
  final String imageTwo;
  final String searchTwo;
  const Highlighted({super.key, required this.imageOne,required this.searchOne,required this.imageTwo,required this.searchTwo});

  @override
  _HighlightedState createState() => _HighlightedState();
}

class _HighlightedState extends State<Highlighted> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        GestureDetector(
          onTap: (){
            checkGender(widget.searchOne, context);
          },
            child: Image.network(widget.imageOne)),
        GestureDetector(
            onTap: (){
              checkGender(widget.searchTwo, context);
            },
            child: Image.network(widget.imageTwo))
        ],
      ),
    );
  }
}
