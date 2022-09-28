import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/constant/appcolor.dart';
import '../shared/styles/thems.dart';

class ProfileDesign extends StatelessWidget {
  final   String text;
 final IconData icon;
 final  GestureTapCallback?  ontap;

   ProfileDesign({Key? key,required this.icon,required this.text, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return   Card(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          width: size.width,
          padding: EdgeInsets.symmetric(vertical: 17,horizontal: 15),
          decoration: BoxDecoration(

            color:Get.isDarkMode? Appcolor.color2:Colors.grey[300],
            borderRadius: BorderRadius.circular(7),

          ),
          child: Row(
            children: [
              Icon(
                icon,color: Colors.deepOrange,),
              SizedBox(width: size.width*.07,),
              Text(text,style: bottomthem2.copyWith(
                  fontSize: 18,

              ),),
              Spacer(),
              Icon(  Icons.arrow_forward_ios_outlined,color: Get.isDarkMode?Colors.grey[400]:Colors.black45,)

            ],
          ),
        ),
      ),
    );
  }
}
