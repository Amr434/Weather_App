import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/shared/constant/appcolor.dart';
import 'package:whether_app/shared/styles/thems.dart';
import 'package:whether_app/utils/edit_profile.dart';
import 'package:whether_app/widget/profile_design.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return GetBuilder<Homecontroler>(
    builder: (controller){
      return controller.profile!=null?
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(top: size.height*.08),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios_new,color: Get.isDarkMode?Colors.grey[200]:Colors.black45,size: 20,),
                  SizedBox(width: size.width*.3,),
                  Text('Profile',style: GoogleFonts.andika(
                      fontSize: 32,
                      color: Get.isDarkMode?Colors.grey[200]:Colors.black45
                  ),),
                  SizedBox(height: 20,),

                ],
              ),
              SizedBox(height: size.height*.06,),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: size.width*.15,
                    backgroundImage: controller.Imageprofil!=null?
                        FileImage(controller.Imageprofil!)as ImageProvider

                    :NetworkImage(
                      controller.profile!.image!
                    ),

                  ),

                  GestureDetector(
                    onTap: (){
                      controller.openImagePicker();
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Appcolor.color2.withOpacity(.8),
                      child: Icon(Icons.camera_alt_sharp,color: Colors.white,),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height*.02,),
              Text(controller.profile!.name.toString(),style: GoogleFonts.aBeeZee(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: size.height*.05,),
              ProfileDesign(icon: Icons.person, text: 'My Account',
                ontap: (){
                  Get.to(EditProfile());
                },
              ),
              SizedBox(height: size.height*.03,),
              ProfileDesign(icon: Icons.notifications, text: 'Notification',ontap: (){

              },),
              SizedBox(height: size.height*.03,),
              ProfileDesign(icon: Icons.help, text: 'Help',
                ontap: (){},
              ),
              SizedBox(height: size.height*.03,),
              ProfileDesign(icon: Icons.logout, text: 'Log Out',
                ontap: (){
                controller.Logout();
                },
              )
            ],
          ),
        ),


      ):
      Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Appcolor.mainColor,
        ),
      );
    },
    );
  }
}
