import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/constant/appcolor.dart';

class Input_field extends StatelessWidget {

  final bool ?ispassword;
  final Size size ;
 final String hintext;
final TextEditingController controller;
 final IconData icon;
 final IconButton ?suficon;
 const Input_field({Key? key,
   required this.size,required this.hintext,
   required this.icon,this.suficon,this.ispassword=false,
   required this.controller
 }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width*.8,
      height: size.height*.07,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(30),
          color: Get.isDarkMode? Appcolor.color2:Colors.grey[300]
      ),
      child: TextFormField(
        controller: controller,
        strutStyle:StrutStyle(

        ) ,
        obscureText:ispassword==true?true:false ,
        decoration: InputDecoration(

            suffixIcon: suficon,
             border: InputBorder.none,
            hintText: hintext,

           prefixIcon: Icon(icon,color: Colors.deepOrange,),

        ),

      ),

    );
  }
}
