import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final Size size;
  final String text;
  final Function ()ontap;
  const RoundedButton({Key? key,required this.size,required this.text,required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        ontap();
      },
      child: Container(
        width: size.width*.8,
        padding: EdgeInsets.symmetric(
            horizontal: size.width*.2,
            vertical: size.width*.035
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.deepOrange
        ),
        child: Center(child: Text(text,style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          color: Colors.white
        ),)),
      ),
    );
  }
}
