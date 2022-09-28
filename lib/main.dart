import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:whether_app/services/services.dart';
import 'package:whether_app/shared/constant/appconstant.dart';
import 'package:whether_app/shared/styles/thems.dart';
import 'package:whether_app/utils/binding/helper.dart';
import 'package:whether_app/utils/binding/homepage.dart';
import 'package:whether_app/utils/getstarted.dart';
import 'package:whether_app/utils/login/login.dart';


void main() async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

await GetStorage.init();
SystemChrome.setSystemUIOverlayStyle(

    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    )
);




Appconst.city= await GetStorage().read('city');
Appconst.uid =await GetStorage().read('uid');
Appconst.getstarted=await GetStorage().read('getstarted');

  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      themeMode:ThemServices().Them,
      theme:Themes.ligth,
      darkTheme: Themes.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',

      getPages: [
        GetPage(

          name: '/',
          page: () {
            if(Appconst.getstarted!=null){
              if(Appconst.uid!=null){
                return Homepage();

              }
              else{
                return LoginScreen();
              }
            }
            else{
              return GetStarted();
            }
          },
          transition: Transition.circularReveal,
          binding: init()


        ),

      ],
    );

  }
}
