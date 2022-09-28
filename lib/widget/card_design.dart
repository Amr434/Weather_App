import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/current_weather.dart';
import 'package:whether_app/shared/constant/appcolor.dart';

import '../shared/styles/thems.dart';

class CardDesign extends GetView<Homecontroler> {



  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  controller.currentWeather!=null?
      Center(
        child:
        Container(
          width: double.infinity,
          child: Stack(





            children: [



              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(size.width*.02),
                      width: size.width*.9,
                      decoration:  BoxDecoration(
                          color: Appcolor.color2,
                          borderRadius: BorderRadius.circular(
                              size.width*.05
                          )
                      ),
                      child: Column(







                  mainAxisAlignment: MainAxisAlignment.start,



                  children: [







                      SizedBox(height: size.width*.01,),



                      Image(



                        fit: BoxFit.cover,



                        width: size.width*.3,



                          height: size.width*.3,



                          image:AssetImage('assets/images/${controller.currentWeather!.weather![0].icon}.png',)



                      ),



                      SizedBox(height: size.width*.01,),



                      Text(controller.currentWeather!.weather![0].description,style: GoogleFonts.lato(



                        fontSize: 18,



                        color:  Colors.grey[200],



                        fontWeight: FontWeight.bold



                      ),),



                      SizedBox(height: size.width*.03,),



                      Container(



                        child: Row(



                          mainAxisAlignment: MainAxisAlignment.center,



                          children: [



                            Text('${(controller.currentWeather!.main!.temp-273.15).round()}\u2103',style: GoogleFonts.lato(



                              fontSize: 35,



                              fontWeight: FontWeight.w800,



                              color: Colors.white70



                            ),),



                            SizedBox(width: 3,),











                          ],



                        ),



                      ),



                      SizedBox(height: 12,),



                      Row(



                        mainAxisAlignment: MainAxisAlignment.center,



                        children: [



                          Text("H:${(controller.currentWeather!.main!.tempMax-273.15).round()}\u2103",style:GoogleFonts.lato(



                            fontSize: 16,



                            color: Colors.grey[300],







                          ),),







                          SizedBox(width: 10,),



                          Text("L:${(controller.currentWeather!.main!.tempMin-273.15).round()}\u2103",style:GoogleFonts.lato(



                            fontSize: 16,



                            color: Colors.grey[300],







                          ))



                        ],



                      ),



                 SizedBox(height: 60,),



                 Row(



                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,



                   children: [



                       Column(







                         children: [



                           Icon(CupertinoIcons.wind,color: Colors.white,),



                           SizedBox(height: 5,),



                           Text('${controller.currentWeather!.wind!.speed!.toInt()}km/h',style:bottomthem),



                           SizedBox(height: 5,),



                           Text('wind',style:bottomthem)



                         ],







                       ),



                       Column(







                         children: [



                           Icon(CupertinoIcons.cloud_moon_rain_fill,color: Colors.white,),



                           SizedBox(height: 5,),



                           Text('${controller.currentWeather!.clouds!.all}%',style:bottomthem),



                           SizedBox(height: 5,),



                           Text('Chance of Rain',style:bottomthem),







                         ],







                       ),



                       Column(







                         children: [



                           Icon(Icons.water_drop_rounded,color: Colors.white,),



                           SizedBox(height: 5,),







                           Text('${controller.currentWeather!.main!.humidity}%',style: bottomthem,),



                           SizedBox(height: 5,),



                           Text('Humdity',style:bottomthem ,)



                         ],







                       ),







                   ],



                 )



                  ],



                ),
                    ),
              ),
              Positioned(
                top: size.height*.2,
                left: 0,
                child: Align(



                  alignment: Alignment.centerLeft,

                  child:Container(

                    height: 30,

                    width: 30,



                    decoration: BoxDecoration(



                        image: DecorationImage(

                            image: AssetImage(

                                'assets/images/cloudicon.png'

                            )

                        )

                    ),

                  ),

                ),
              ),
              Positioned(

                top: size.height*.3,

                right: 0,

                child: Align(



                  alignment: Alignment.bottomRight,

                  child:Container(

                    height: 30,

                    width: 30,



                    decoration: const BoxDecoration(



                        image: DecorationImage(

                            image: AssetImage(

                                'assets/images/cloudicon.png'

                            )

                        )

                    ),

                  ),

                ),

              ),

            ],

          ),
        ),
      ):SizedBox.shrink();
  }
}
