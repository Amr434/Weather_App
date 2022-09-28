import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/shared/constant/appcolor.dart';
import 'package:whether_app/utils/binding/homepage.dart';
import 'package:whether_app/utils/login/component/rounded_button.dart';

import 'component/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TextEditingController emailcontroller;
  late TextEditingController namecontroller;
 late TextEditingController passwordcontroller;
  bool islogin=true;
  bool ispassword=true;
  Animation<double>? containersize;
 late AnimationController animationController;
 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.restoreSystemUIOverlays();
    emailcontroller=TextEditingController();
    passwordcontroller=TextEditingController();
    namecontroller=TextEditingController();
    animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 470));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    var size=MediaQuery.of(context).size;
    double viewinset=MediaQuery.of(context).viewInsets.bottom;

    double defaultregistersize=size.height-(size.height*0.1);
    containersize=Tween<double>(begin:size.height*.1 ,end:defaultregistersize ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));



    return GetBuilder<Homecontroler>(
      builder: (controller){
        return  Scaffold(
          body: Stack(
            children: [

              Visibility(
                visible: islogin,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        viewinset==0?
                        Text('Welcome Back',style: GoogleFonts.roboto(
                            fontSize: 25,fontWeight: FontWeight.bold
                        ),)
                            :SizedBox.shrink(),
                        SizedBox(
                          height: size.height*.05,
                        ),
                        SvgPicture.asset(
                            'assets/images/login.svg'
                        ),
                        SizedBox(
                          height: size.height*.1,
                        ),
                        Input_field(size: size,icon: Icons.email,hintext: 'Username', controller: emailcontroller,),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        Input_field(size: size,icon: CupertinoIcons.lock,hintext: 'Password',
                          suficon: IconButton(
                            focusColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            splashColor: Colors.transparent,
                            autofocus: false,
                            onPressed: (){
                              setState((){
                                ispassword=!ispassword;
                              });

                            },
                            icon:Icon(ispassword!=true?Icons.visibility:Icons.visibility_off,color: Colors.deepOrange,) ,
                          ),
                          ispassword: ispassword? true:false, controller: passwordcontroller,
                        ),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        RoundedButton(size: size, text: 'Login', ontap: (){
                          controller.login(
                            email: emailcontroller.text,
                            password: passwordcontroller.text
                          );
                        }),
                        SizedBox(
                          height: size.height*.1,
                        ),





                      ],
                    ),
                  ),
                ),
              ),

              AnimatedBuilder(
                animation: animationController,
                builder: (context,child){
                  if(islogin&&viewinset==0){
                    return Registerbuilder(size);
                  }
                  else {
                    return SizedBox.shrink();
                  }
                },
              ),


              Visibility(
                visible: !islogin,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        SizedBox(
                          height: size.height*.05,
                        ),
                        SvgPicture.asset(
                            'assets/images/register.svg'
                        ),
                        SizedBox(
                          height: size.height*.1,
                        ),
                        Input_field(size: size,icon: Icons.email,hintext: 'Username', controller: emailcontroller,),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        Input_field(
                          size: size,
                          icon: Icons.face_outlined,hintext: 'Name',

                          ispassword: false,
                          controller: namecontroller,
                        ),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        Input_field(size: size,
                          icon: CupertinoIcons.lock,
                          hintext: 'Password',
                          suficon: IconButton(
                            focusColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            splashColor: Colors.transparent,
                            autofocus: false,
                            onPressed: (){
                              setState((){
                                ispassword=!ispassword;
                              });
                            },
                            icon:Icon(ispassword==true?Icons.visibility_off:Icons.visibility,color: Colors.deepOrange,) ,
                          ),
                          ispassword: ispassword?true:false,
                          controller: passwordcontroller,
                        ),
                        SizedBox(
                          height: size.height*.03,
                        ),
                        RoundedButton(size: size, text: 'Sign Up',
                            ontap: (){
                          controller.createuser(
                              email: emailcontroller.text,
                              password: passwordcontroller.text,
                              name: namecontroller.text
                          );
                        }),
                        SizedBox(
                          height: size.height*.1,
                        ),





                      ],
                    ),
                  ),
                ),
              ),



              AnimatedOpacity(
                opacity: islogin?0.0:.2,
                duration: Duration(seconds: 1),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(

                    margin: EdgeInsets.only(
                        top: 20
                    ),
                    width: double.infinity,
                    height: size.height*.1,
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      icon: Icon(Icons.clear,color: Get.isDarkMode?Colors.white:Colors.black,),

                      onPressed: (){
                        animationController.reverse();
                        setState((){
                          islogin=!islogin;

                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),


        );
      },
    );
  }
  Widget Registerbuilder(size){
   return  Align(
     alignment: Alignment.bottomCenter,
     child: Container(
       width: double.infinity,
       height:containersize!.value,
       decoration: BoxDecoration(
           color: Get.isDarkMode?Appcolor.color2:Colors.grey[200],
           borderRadius:
           BorderRadius.only(
               topLeft: Radius.circular(size.height*.1),
               topRight: Radius.circular(size.height*.1))
       ),
       alignment: Alignment.center,
       child: InkWell(
         onTap: (){
           animationController.forward();
           setState((){
            islogin=!islogin;
           });

         },
         child:islogin?const Text('Don\'t  have account ?' ,style: TextStyle(
             color: Colors.deepOrange,
             fontSize: 18
         ),):const SizedBox.shrink(),
       ),
     ),
   );
  }
}
