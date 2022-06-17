import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  //const Buttons({ Key? key }) : super(key: key);

  final Color_b;
  final TextColor;
  final String ButtonText;
  final ButtonTapped;

  Buttons({this.Color_b,this.TextColor,required this.ButtonText,this.ButtonTapped});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ButtonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect (
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color:Color_b,
            child: Center(child: Text(ButtonText,style: TextStyle(color: TextColor,fontSize: 20),)),
          ),
          
        ),
       
      ),
    );
  }
}