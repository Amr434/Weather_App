import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whether_app/shared/constant/appcolor.dart';
import 'package:whether_app/shared/constant/appconstant.dart';
import 'package:whether_app/utils/Mainhome.dart';
import 'package:whether_app/utils/login/login.dart';

import 'binding/homepage.dart';
// 08172E
//15253f
class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  PageController controller=PageController();
  bool islast=false;
  double currentpage=0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      setState((){
        currentpage=controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

 print(currentpage);
    @override
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(



                itemCount: 3,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,

               controller: controller,
                itemBuilder: (context,index){
                  return itembuilder(size);
                },

              ),
            ),
       DotsIndicator(
        dotsCount: 3,

        position: currentpage,
        decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeColor: Appcolor.mainColor,
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
      SizedBox(height: size.height*.07,),
            GestureDetector(
              onTap: (){
                if(currentpage==2){
                  GetStorage().write('getstarted', true).then((value) {
                    Get.to(LoginScreen());
                  });
                }
                else{
                  controller.nextPage(duration: Duration(milliseconds: 520), curve: Curves.linear);
                  print("wait");
                }
                //  Get.to(Homepage());


              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Appcolor.mainColor
                ),

                child:Text(currentpage<2?'Next':'Get Started',style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold

                ),) ,
              ),

            ),
            SizedBox(
              height: size.height*.1,
            ),


          ],
        ),

      ),

    );

  }

  Widget itembuilder(size){
    return Container(
      width: size.width,
      height: size.height*.5,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/getstarted.jpg',
              )
          )
      ),

    );
  }
}
