import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/models/user_profile.dart';
import 'package:whether_app/shared/constant/appcolor.dart';
import 'package:whether_app/widget/edit_input_field.dart';
class EditProfile extends StatelessWidget {

  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    TextEditingController namecontroler=TextEditingController();
    TextEditingController emailcontroler=TextEditingController();
    TextEditingController passwordcontrole=TextEditingController();

    return GetBuilder<Homecontroler>(
      builder: (controler){
        namecontroler.text=controler.profile!.name!;
        emailcontroler.text=controler.profile!.email!;
        passwordcontrole.text=controler.profile!.password!;
        return
          Scaffold(
            body:controler.profile!=null?
            Container(
                width: size.width,
                height: size.height,
                child:
                Stack(
                  children: [
                    Positioned(
                      top: size.height*.08,
                      left: 0,
                      right: 0,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed:(){
                            Get.back();
                          },
                            icon: Icon(Icons.arrow_back_ios_new,size: 18,),

                          ),
                          Text('EDIT PROFILE',style: GoogleFonts.lato(
                              fontSize: 23,
                              fontWeight: FontWeight.w300
                          ),),
                          IconButton(onPressed: (){

                            if(controler.Imageprofil!=null){
                               controler.UploadImagestore(
                                   name: namecontroler.text,

                               );
                            }
                            else{
                              controler.updateprofiledata(
                                  name: namecontroler.text,

                              );
                            }

                          }, icon: Icon(Icons.check))
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height*.17,
                      left: (size.width/2)-(size.width*.15),
                      right: (size.width/2)-(size.width*.15),

                      child: Stack(
                        alignment: Alignment.bottomRight,

                        children: [
                          CircleAvatar(

                            radius: (size.width*.15),

                            backgroundImage:controler.Imageprofil!=null?
                                FileImage(controler.Imageprofil!) as ImageProvider
                           : NetworkImage(
                               controler.profile!.image!
                            ) ,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Appcolor.color2.withOpacity(.8),
                            child: IconButton(
                              onPressed: (){
                                controler.openImagePicker();
                              },
                              icon: Icon(Icons.camera_alt_sharp,color: Colors.white,),
                            ),


                          )

                        ],
                      ),

                    ),
                    Positioned(
                        top: size.height*.36,
                        left: size.width*.1,
                        right: size.width*.1,
                        bottom: 0,

                        child:Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Center(
                                  child: Text(controler.profile!.name!,style: GoogleFonts.aBeeZee(
                                    fontSize: 22,

                                  ),),
                                ),
                                if(controler.isupdated==false)
                                SizedBox(height: 10,),
                                if(controler.isupdated==false)
                                LinearProgressIndicator(
                                  backgroundColor:Get.isDarkMode?Colors.grey:Appcolor.mainColor,
                                  color: Get.isDarkMode?Appcolor.mainColor:Colors.grey,
                                ),
                                SizedBox(height: size.height*.05,),
                                Text('Puplic Information',style: GoogleFonts.lato(
                                    fontSize: 20
                                ),),
                                SizedBox(height: size.height*.02,),
                                EditField(hint: 'Name', controller:namecontroler ,label: 'Name'),
                                SizedBox(height: size.height*.02,),
                                EditField(hint: 'Password', controller:passwordcontrole ,label: 'Password'),
                                SizedBox(height: size.height*.02,),
                                EditField(hint: 'Email', controller:emailcontroler,label: 'Email', )

                              ],
                            ),
                          ),
                        )
                    )

                  ],
                )
            ):
            const Center(
              child: CircularProgressIndicator(
                backgroundColor: Appcolor.mainColor,
                color: Colors.white,
              ),
            ),
          );
      },
    );
  }
}
