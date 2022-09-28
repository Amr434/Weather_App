
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whether_app/services/services.dart';

import '../constant/appcolor.dart';

class Themes{

 static final dark=ThemeData(
   scaffoldBackgroundColor:Appcolor.mainColor,
   brightness: Brightness.dark,

 );
 static final ligth=ThemeData(

     scaffoldBackgroundColor:Colors.white,
     brightness: Brightness.light

 );





}
TextStyle  get appbarstyle{

  return
    GoogleFonts.content(
    color:Get.isDarkMode?Colors.white:Colors.black54 ,
    fontWeight: FontWeight.w800,
    fontSize: 20
  );
}
TextStyle  get  bottomthem {

 return GoogleFonts.lato(
     fontSize:16,
  color :Colors.grey[400]

 );

}
TextStyle  get  bottomthem2 {

  return GoogleFonts.lato(
      fontSize:16,
      color :Get.isDarkMode?Colors.grey[400]:Colors.black45

  );

}