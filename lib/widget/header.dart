import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/current_weather.dart';
import '../services/services.dart';
import '../shared/constant/appcolor.dart';
import '../shared/styles/thems.dart';



class HeaderTitle extends StatelessWidget {


  @override


  @override
  Widget build(BuildContext context) {
TextEditingController textcontroller=TextEditingController();
var size=MediaQuery.of(context).size;
    return    GetBuilder<Homecontroler>(
      builder: (controler){
      return controler.currentWeather!=null?
      Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // icon design
           IconButton(onPressed: (){
             Get.bottomSheet(
                 Container(
                   padding: EdgeInsets.all(size.width*.08),
                   width: double.infinity,
                   height: size.height*.25,
                   color: Get.isDarkMode?Appcolor.mainColor:Colors.white,
                   child:
                   Column(
                     children: [
                       TextFormField(

                         decoration: InputDecoration(

                         border: OutlineInputBorder(


                         ),
                           prefixIcon: Icon(Icons.search_rounded),
                           labelText: 'City',
                           labelStyle: bottomthem.copyWith(
                             fontWeight: FontWeight.bold
                           ),
                           focusColor: Colors.amberAccent
                         ),
                        autovalidateMode:AutovalidateMode.onUserInteraction,
                        onFieldSubmitted: (String city){
                           if(city!=null||city!=''||textcontroller.text!='')
                           {
                             controler.getcurrentdata(city).then((value){
                               GetStorage().write('city', city).then((value) {
                                 Get.back();
                               });
                             });
                           }







                        },
                         onSaved: (String? city){
                           if(city!=null||city!=' '||textcontroller.text!=''){
                             controler.getcurrentdata(city!).then((value){
                               controler.getfivedays(city).then((value) {

                                 GetStorage().write('city', textcontroller.text).then((value) {
                                   Get.back();
                                 });
                               });


                             });
                           }



                         },
                         controller: textcontroller,
                         autocorrect: true,

                         style: bottomthem,


                       ),
                       SizedBox(height: size.height*.03,),
                       GestureDetector(

                         child: Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5),
                             border: Border.all(
                               color: Colors.grey,

                             )
                           ),
                           child: Center(child: Text('Close',style: bottomthem,)),
                           width: size.width*.9,
                           padding: EdgeInsets.symmetric(vertical: 10),
                           height: size.height*.06,
                         ),
                         onTap: (){
                           Get.back();
                         },
                       )
                     ],

                   ),
                 )
             );
           //  controler.getcurrentdata('saudan');
           }, icon: Icon(Icons.search)),
            // name design
            Row(
              children: [
                Icon( CupertinoIcons.location_solid,size: 20,color:Colors.grey,),
                SizedBox(width: 5,),
                Text('${controler.currentWeather!.name}',style: GoogleFonts.aBeeZee(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ?Colors.grey[400]:Colors.grey
                ),),

              ],
            ),
            GestureDetector(
              onTap: (){

                ThemServices().swiththem();
                controler.update();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                decoration: BoxDecoration(
                    color:Appcolor.color2,
                    borderRadius: BorderRadius.circular(size.width*.03)
                ),
                child: Row(
                  children: [
                    Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color:Get.isDarkMode?  Colors.amberAccent:Colors.transparent,
                            shape:BoxShape.circle
                        ),
                        padding: EdgeInsets.all(3),

                        child:  Icon(Icons.sunny,size: 16,color: Colors.white,)),

                    SizedBox(width: 6,),
                    Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Get.isDarkMode?Colors.transparent:Colors.amberAccent,
                            shape:BoxShape.circle
                        ),
                        padding: EdgeInsets.all(3),

                        child: Icon(Icons.nightlight_sharp,size:16,color: Colors.white,))
                  ],
                ),
              ),
            )

          ],
        ),

      ):SizedBox.shrink();
    },
    );
  }
}
