import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/fivedays.dart';
import 'package:whether_app/shared/constant/appcolor.dart';
import 'package:get/get.dart';
import 'package:whether_app/shared/styles/thems.dart';
import 'package:whether_app/utils/binding/homepage.dart';
class Nexdays extends StatelessWidget {
  const Nexdays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return GetBuilder<Homecontroler>(
      builder: (controler){
        FiveDays ?tomorrow;



           String current =DateFormat('MM/dd/yyy').format(DateTime.now());
           String tomowrrotime =DateFormat('MM/dd/yyy').format(DateTime.now().add(Duration(days: 1)));
           int? count=controler.fivedaytime[current];
           for(int i=0;i<controler.fivedaytime.length;i++){

             if(controler.fivedaytime.containsKey(tomowrrotime)){
               var x=controler.fivedaytime[tomowrrotime];
               count=count!+x!;

               tomorrow=controler.fivedays[count-1];
               break;

             }
             else{

               break;


           }

         }




        return Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height*.08,
                  left: 0,
                  right: 0,
                  child: Row(

                    children: [
                      SizedBox(width: 5,),
                      GestureDetector(

                        onTap: (){
                      Get.to(Homepage());
                        },
                        child: CircleAvatar(
                            radius: size.width*.06,

                            backgroundColor: Get.isDarkMode?Appcolor.color2:Colors.grey[400],
                            child: Icon(Icons.arrow_back_ios_new,size: 18,color:Get.isDarkMode? Colors.white:Colors.black54,)
                        ),


                      )   ,
                      SizedBox(width: size.width*.3,),
                      Icon(Icons.date_range_outlined,color: Colors.grey,size: 21,),
                      SizedBox(width: 3,),
                      Text('Next ${controler.fivedaytime.length} days',style: bottomthem2.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),

                ),

                Positioned(
                    top: size.height*.17,
                    left: 0,
                    right: 0,
                    child:   Container(
                      width: double.infinity,

                      child: Stack(





                        children: [

                          Positioned(
                            top: size.height*.1,
                            left: size.width*.017,
                            child: Align(



                              alignment: Alignment.centerLeft,

                              child:Container(

                                height: 50,
                                width: 50,

                                foregroundDecoration: BoxDecoration(
                                  color:Get.isDarkMode? Appcolor.mainColor.withOpacity(.7):Colors.transparent,
                                ),

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
                            right:  size.width*.017,
                            child: Align(

                              alignment: Alignment.bottomRight,

                              child:Container(
                                foregroundDecoration: BoxDecoration(
                                  color:Get.isDarkMode? Appcolor.mainColor.withOpacity(.7):Colors.transparent,
                                ),

                                height: 50,
                                width: 50,

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

                          Align(
                              alignment: Alignment.center,
                              child: tomorrow!=null? itembuilder(size,tomorrow):SizedBox.shrink()
                          ),
                        ],

                      ),
                    )
                ),
                Positioned(
                  top: size.height*.59,
                  bottom: 0,
                  right: 20,
                  left: 20,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: controler.fivedays.length>0? ListView.separated
                        (
                        physics: BouncingScrollPhysics(),

                        scrollDirection: Axis.vertical,
                          itemBuilder:(context,index){
                          List<FiveDays>fivedayobj=[];
                          int count=0;
                         controler.fivedaytime.entries.forEach((element) {
                           for(int i=count;i<count+1;i++){
                             fivedayobj.add(controler.fivedays[count]);
                           }
                           count=count+element.value;

                         });


                            return buildays(fivedayobj[index]);


                      },
                          separatorBuilder:(context,index){
                            return
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 20
                                ),
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[200],
                              );
                      },
                          itemCount: controler.fivedaytime.length

                      ):Center(child:
                        CircularProgressIndicator(
                          color: Get.isDarkMode?Colors.white:Appcolor.mainColor,
                        ),),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildays(FiveDays? fivedayobj){
    DateTime parse =DateFormat('yyy-MM-dd HH:mm:ss').parse(fivedayobj!.dt_txt);
    var output= DateFormat.E().format(parse);


    return      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(output,style: bottomthem2,)
        ),
        Row(
          children: [
            Image(
              width: 40,
                height: 40,
                image: AssetImage(
              'assets/images/${fivedayobj.wheather[0].icon}.png'
            )),
            SizedBox(width: 5,),
            Text(fivedayobj.wheather[0].description,style: bottomthem2,)
          ],
        ),
       Row(
         children: [
           Text('${(fivedayobj.main!.temp-273.15).round()}°',style: bottomthem2),
           SizedBox(width: 20,),
           Text('${(fivedayobj.main!.tempMin-273.15).round()}°',style: bottomthem2,),

         ],
       )
      ],
    );
  }





  Widget itembuilder(Size size, FiveDays tomorrow){
    return  GetBuilder<Homecontroler>(
      builder: (controller){

        return Container(
          padding: EdgeInsets.all(size.width*.02),
          width: size.width*.9,
          height: size.height*.4,
          decoration:  BoxDecoration(
              color: Get.isDarkMode?Appcolor.color2.withOpacity(.6):Colors.grey[200]!.withOpacity(.6),
              borderRadius: BorderRadius.circular(
                  size.width*.05
              )
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           Expanded(
             flex: 2,
             child:Container(

             width: size.width*.8,
             child:
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Expanded(child: Image(image: AssetImage('assets/images/${tomorrow.wheather[0].icon}.png'))),
                 Expanded(child:
                 Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Text('Tomorrow ',style: appbarstyle,),
                     SizedBox(
                       height: size.width*.01,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('${(tomorrow.main!.tempMax-273.15).round()}°',style:GoogleFonts.aBeeZee(
                             fontSize: 35,
                             fontWeight: FontWeight.bold,
                           color: Get.isDarkMode?Colors.grey:Colors.black45

                         ),),
                         Text('/${(tomorrow.main!.tempMax-273.15).round()}°',style:GoogleFonts.aBeeZee(
                             fontSize: 25,
                             fontWeight: FontWeight.bold,
                             color: Get.isDarkMode?Colors.grey:Colors.black45

                         ) ,)
                       ],
                     ),
                     SizedBox(
                       height: size.width*.01,
                     ),
                     Text('${tomorrow.wheather[0].description}',style: bottomthem2.copyWith(
                       fontSize: 20
                     ),),


                   ],
                 ))
               ],
             ),

           ), ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [

                        Icon(CupertinoIcons.wind,color: Get.isDarkMode?Colors.white:Colors.black45,),
                        SizedBox(height: 5,),
                        Text('${controller.currentWeather!.wind!.speed!.toInt()}km/h',style:bottomthem2),
                        SizedBox(height: 5,),

                        Text('wind',style:bottomthem2)



                      ],







                    ),

                    Column(
                      children: [
                        Icon(CupertinoIcons.cloud_moon_rain_fill,color: Get.isDarkMode?Colors.white:Colors.black45,),
                        SizedBox(height: 5,),
                        Text('${tomorrow.clouds!.all}%',style:bottomthem2),
                        SizedBox(height: 5,),
                        Text('Chance of Rain',style:bottomthem2),
                      ],
                    ),

                    Column(
                      children: [
                        Icon(Icons.water_drop_rounded,color: Get.isDarkMode?Colors.white:Colors.black45,),
                        SizedBox(height: 5,),
                        Text('${tomorrow.main!.humidity}%',style: bottomthem2,),
                        SizedBox(height: 5,),
                        Text('Humdity',style:bottomthem2,


                        )
                      ],

                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
