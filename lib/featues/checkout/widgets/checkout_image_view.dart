
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CheckoutImagesView extends StatefulWidget {
  final List<dynamic> pImg;
  final double height;
  final Map oData;
  const CheckoutImagesView({required this.pImg, required this.height, required this.oData});
  @override
  _CheckoutImagesViewState createState() => _CheckoutImagesViewState();
}

int curIm = 0;

class _CheckoutImagesViewState extends State<CheckoutImagesView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> CaroItm = [];
    for (int i = 0; i < widget.pImg.length; i++) {
      CaroItm.add(Image(
        image: NetworkImage(widget.pImg[i].toString()),
        fit: BoxFit.fitHeight,
      ));
    }
    return CarouselSlider(
      items: CaroItm,
      options: CarouselOptions(height: widget.height, viewportFraction: 0.4,enlargeCenterPage: true,enableInfiniteScroll: false),
    );
  }
}