import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whether_app/utils/Mainhome.dart';
import 'package:whether_app/utils/Nointernet.dart';
import 'package:whether_app/utils/profile.dart';
import '../../controler/homecontroler.dart';
import '../../shared/constant/appcolor.dart';
import '../nexdays.dart';


class Homepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {



    List<Widget>screens=[
      Mainhome(),
      Nexdays(),
     Profile()
    ];
    return  GetBuilder<Homecontroler>(builder: (controler){

    //   controler.checkconection();

      return  controler.internet?
      Scaffold(

          body: screens[controler.currentindex],
          bottomNavigationBar:  CurvedNavigationBar(
            index: controler.currentindex,
            buttonBackgroundColor:Get.isDarkMode?
            Colors.blue.withOpacity(.7):Appcolor.color2.withOpacity(.9),
            backgroundColor: Colors.transparent,
            color: Appcolor.color2,
            height: 70,
            animationCurve:Curves.linear ,
            items: const <Widget>[
              Icon(Icons.home_filled, size: 30,color:Colors.white),
              Icon(Icons.next_plan_outlined, size: 30,color: Colors.white,),
              Icon(Icons.person, size: 30,color: Colors.white,),
            ],
            onTap: (index) {

                controler.changecurrentindex(index);


            },
          )
      ):
      Scaffold(
       body: NoInternet(),
      );
    });


  }
}

