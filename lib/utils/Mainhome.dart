import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/fivedays.dart';

import 'package:whether_app/shared/constant/appcolor.dart';
import 'package:whether_app/utils/Nointernet.dart';

import 'package:whether_app/widget/header.dart';

import '../shared/styles/thems.dart';
import '../widget/card_design.dart';
import 'package:get/get.dart';
import '../widget/my_chart.dart';
import 'nexdays.dart';

class Mainhome extends StatefulWidget {
  const Mainhome({Key? key}) : super(key: key);

  @override
  State<Mainhome> createState() => _MainhomeState();
}

class _MainhomeState extends State<Mainhome> {
  @override
  Widget build(BuildContext context) {

    Size size =MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<Homecontroler>(
          builder: (controller)  {

            List<FiveDays> lastfivdays=[];
              var current =DateFormat('MM/dd/yyy').format(DateTime.now());
              for(int j=0;j<controller.fivedaytime.length;j++) {

                if(controller.fivedaytime.containsKey(current)) {
                  var v = controller.fivedaytime[current];
                  int? count=v;
                  for(int i=0;i<count!;i++){
                    lastfivdays.add(controller.fivedays[i]);
                  }
                  break;
                }
              }

            return
              controller.isloaded==true?
              Stack(

             children: [
               Positioned(
                 top: size.height*.06,
                 left: size.width*.02,
                 right: size.width*.02,
                 child: HeaderTitle()
               ),

               Positioned(
                     top:size.height*.15 ,
                     left: 10,
                     right: 10,
                     bottom: 0,
                     child:    Stack(


                       children: [

                         SingleChildScrollView(
            physics: BouncingScrollPhysics(),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                   width: double.infinity,
                                   child: Column(
                                     children: [
                                       Text('Today',style: appbarstyle.copyWith(
                                         color:Colors.grey ,
                                       ),),
                                       SizedBox(height: size.height*.01,),
                                       Text(DateFormat.MMMEd().format(DateTime.now()).toString(),style: appbarstyle.copyWith(
                                           color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
                                           fontSize: 16,
                                           fontWeight: FontWeight.normal
                                       ),)
                                     ],
                                   ),
                                 )
                                 ,SizedBox(height: size.height*.01,),
                                 CardDesign(),
                                 SizedBox(height: size.height*.02,),
                                 GestureDetector(
                                   onTap:(){
                                     Get.to(Nexdays());
                                   },
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                      Text("Next days ",style: bottomthem.copyWith(
                                         fontSize: 18
                                       ),),
                                       Icon(Icons.arrow_forward_ios,size: 16,color: Colors.grey,)
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: size.height*.02,),
                                 Divider(
                                   height: 1,
                                   color: Colors.grey[600],
                                 ),
                                 SizedBox(height: size.height*.02,),
                                   Padding(
                                     padding: const EdgeInsets.only(left: 5),
                                     child: Text('Today',style: bottomthem,),
                                   ),



                                 Container(
                                   padding: EdgeInsets.only(top: 20,left: 20),
                                   height: 150,
                                   width: double.infinity,
                                    child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                  itemCount: lastfivdays.length,

                     itemBuilder:(context,index)=> Column(

                                       children: [


                                         Image(
                                           width: 50,
                                             height: 50,
                                             image: AssetImage('assets/images/${lastfivdays[index].wheather[0].icon}.png')),
                                         SizedBox(height: size.height*.02,),
                                         Text('${(lastfivdays[index].main!.temp-273.15).round()}°'),
                                         SizedBox(height: size.height*.04,),
                                         Text('${
                                            DateFormat('HH:ss').format(DateFormat('yyy-MM-dd HH:mm:ss').parse(lastfivdays[index].dt_txt))
                                         }')
                                       ],
                                     ),
                                      separatorBuilder: (context,index){
                                        return lastfivdays.length<= 4?SizedBox(width: 60,):SizedBox(width: 45,);
                                      },
                                 )
            ),


                                 SizedBox(height: size.height*.01,),
                                 MyChart(),

                               ],
                             ))

                       ],
                     ),
                   ),





             ],
            ):
              Center(
               child:CircularProgressIndicator(
                 color: Colors.white,
                 backgroundColor: Appcolor.mainColor,
               ),

            );
          }
      ),


    );


  }
}
