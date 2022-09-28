
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:whether_app/models/fivedays.dart';
import 'package:whether_app/models/user_profile.dart';
import 'package:whether_app/repository/homRepository.dart';
import 'package:whether_app/shared/constant/appconstant.dart';
import 'package:whether_app/utils/binding/homepage.dart';
import 'package:whether_app/utils/login/login.dart';
import '../models/current_weather.dart';

class Homecontroler extends GetxController{

 HomRepo homRepo;



//https://api.openweathermap.org/data/2.5/forecast?q=cairo&appid=4e9c5501ef9621fdea76a49c19bb7e33
Homecontroler({required this.homRepo});

  bool _isloaded=false;
  double _longtude=0.0;
 double _lattude=0.0;
  double get longtude=>_longtude;
  double get lattude=>_lattude;
  bool get isloaded =>_isloaded;
  String ?citylocation;
@override
void onInit() {
    // TODO: implement onInit
  // getlcation();
  getlocation2();

  }

  getlocation2() async{

   loc.Location location =loc.Location();


    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
   await getlocation(_locationData.latitude, _locationData.longitude);
  }

  // Future<dynamic> getlcation() async{
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition().then((value) {
  //     _lattude=value.latitude;
  //     _longtude=value.longitude;
  //     print("lat"+_lattude.toString());
  //     print("long"+_longtude.toString());
  //     getlocation(value.latitude, value.longitude);
  //
  //   });
  //
  // }

 Future<void> getlocation(lat,long)async{


    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark placemark=placemarks[0];
    citylocation=placemark.administrativeArea!;

   getcurrentdata(placemark.subAdministrativeArea!);


  }




  CurrentWeather ?currentWeather;
 Future<void> getcurrentdata(String city)async{

 String url='/${Appconst.WHEATHER}?q=$city&lang=[en,ar]&${Appconst.Apikey}';
 homRepo.getcurrentdata(url).then((value) async{

    currentWeather=CurrentWeather.fromJson(value.body);

 await  getfivedays(city).then((value) {

     GetStorage().write('city', city);
     _isloaded=true;
     update();
   }
   );


 }

 ).catchError((e){
   Get.snackbar("City Search",
     '${city} Not found ',

     duration: Duration(seconds: 2),
     backgroundColor: Colors.green,
     colorText: Colors.white,

   );
update();

 });


  }


  List<FiveDays> fivedays=[];
  Future< void> getfivedays(city)async{

    String url='/${Appconst.FORECAST}?q=$city&${Appconst.Apikey}';
    homRepo.getcurrentdata(url).then((value) async {
      fivedays=[];
      (
      await    value.body['list'] as List).forEach((element) {
       fivedays.add(FiveDays.fromjson(element));
      });


   await getdayoftime().then((value) {update();});

    }).catchError((e){
      print(e.toString());

    });

  }



  Map<String,int> fivedaytime={};
  Future<void> getdayoftime() async{

    fivedaytime={};
    fivedays.forEach((element) {
      var datatimeparsed= DateFormat("yyyy-MM-dd HH:mm:ss").parse(element.dt_txt);
      var outdatatime=  DateFormat("MM/dd/yyy").format(datatimeparsed);



      if(fivedaytime.containsKey(outdatatime)){
        fivedaytime.update(outdatatime, (value) => ++value);
      }
      else
        fivedaytime.putIfAbsent(outdatatime, () => 1);
    });



  }


  Future<void> createuser({
  required String email,
    required String password,
    required String name,
    String image='https://img.freepik.com/free-photo/guy-suit-sits-chair-holds-book_197531-23264.jpg?size=626&ext=jpg&uid=R73775526&ga=GA1.2.1763043540.1657195331',
})
  async{
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
    then((value1)async {

        await createuserregister(
             email: email,
             password: password,
           name: name,
           uid: value1.user!.uid,
          image: image
         ).then((value) {
          Get.snackbar("Login Sucess ",
            'User Login Sucess',
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            colorText: Colors.white,

          );
          GetStorage().write('uid',value1.user!.uid ).then((value) {
          getuserProfile(uid: value1.user!.uid).then((value) {
            Get.to(Homepage());
          });
          }
          ).catchError((e) {
            print(e.toString());

          });
        });

    }).catchError((e){
      Get.snackbar(
        "Register Error ",
        e.toString(),
        duration: Duration(milliseconds: 820),
        backgroundColor: Colors.red,
        colorText: Colors.white,

      );
    });

  }
  Future <void>createuserregister({
  required String email,
  required String password,
  required String name,
  required String uid,
    required String image,

  }
) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).
    set(
        {
          'name': name,
          'uid': uid,
          'password': password,
          'email': email,
          'image':image
        }

    );
  }

  Future<void>login({
  required String email,
    required String password

}) async{
   await FirebaseAuth.instance.
   signInWithEmailAndPassword(email: email, password: password).
   then((value1) {
     getuserProfile( uid: value1.user!.uid).then((value) {
       Get.snackbar("Login ",
         'User Login Sucess',
         duration: Duration(milliseconds: 520),
         backgroundColor: Colors.green,
         colorText: Colors.white,

       );
       GetStorage().write('uid', value1.user!.uid).then((value) {
         Get.to(Homepage());

       });
     });


    }).catchError((e){
      Get.snackbar('Error Login', e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
   });

  }



  void Logout(){
    GetStorage().remove('uid').then((value){
      Get.to(LoginScreen());

    });
    update();
  }
   ProfilModel? profile;
  Future<void> getuserProfile({required String uid}) async{

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      profile=ProfilModel.fromjson(value.data()!);
      print(profile!.name);
      update();
    }).catchError((e){
      print("login error ${e.toString()}");
update();
    });


  }

// List<String>cites=[
//   'sohag',
//   'cairo',
//   'Asyut',
//   'qena',
//   'minya'
// ];
//



  // Future< void> getfivecities()async{
  //   fivecites=[];
  //   cites.forEach((element) {
  //     String url='/${Appconst.WHEATHER}?q=$element&${Appconst.Apikey}';
  //     homRepo.getcurrentdata(url).then((value)
  //     {
  //       fivecites.add(CurrentWeather.fromJson(value.body));
  //     }
  //     ).catchError((e){
  //       print(e);
  //     });
  //   });
  //
  //   update();
  //
  // }
  File? Imageprofil;
ImagePicker imagePicker=ImagePicker();


Future<void>openImagePicker() async{
  var picked=await imagePicker.pickImage(source: ImageSource.gallery,);
  if(picked!=null){
    Imageprofil=File(picked.path);
  }
  else{
    Imageprofil=null;
  }
  update();



}

Future<void>UploadImagestore({
  required String name,
}) async{
  FirebaseStorage.instance.ref().child('images/${Uri.parse(Imageprofil!.path).pathSegments.last}')
      .putFile(Imageprofil!). then((value){
        value.ref.getDownloadURL().then((value) {

          updateprofiledata(name: name,image: value.toString());
        }).catchError((e){
          print("download error"+e.toString());
        });


  }).catchError((e){
    print("put image"+e.toString());
  });

}
bool _isupdated=true;
bool get isupdated=>_isupdated;
updateprofiledata({
    required String name ,
   String? image,

}){
  _isupdated=false;
  update();



  FirebaseFirestore.instance.collection('users').doc(Appconst.uid).update({
    'name':name,
    'image':image??profile!.image
  }).then((value) {

    getuserProfile(uid: Appconst.uid!);
    _isupdated=true;
    update();
  }).catchError((e){
    print("firsotr error ${e.toString()}");

  });
}



  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
  //     print("google name"+value.user!.displayName.toString());
  //
  //    createuserregister(email: 'amrkasban37@gmail.com', password: '123456',
  //        name: value.user!.displayName!, uid: value.user!.uid,
  //        image: 'https://firebasestorage.googleapis.com/v0/b/wheather-app-12aae.appspot.com/o/images%2Fimage_picker8758285527387602318.jpg?alt=media&token=e51aa2bf-7c30-4256-b462-21d24f18a184'
  //    ).then((valu){
  //      GetStorage().write('uid', value.user!.uid).then((valu) {
  //        getuserProfile(uid: value.user!.uid).then((value) {
  //          Get.to(Homepage());
  //        });
  //      }).catchError((e){
  //        print("error"+e.toString());
  //      });
  //    }).catchError((e){
  //      print(e.toString());
  //    });
  //     return value;
  //   }).catchError((e){
  //     print("credial error"+e.toString());
  //   });
  //
  // }
  //

  bool internet=false;
   checkconection() async{

    var listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          internet=true ;
          GetStorage().write('connect', true);
          print('You are connect from the internet.');

          break;

        case InternetConnectionStatus.disconnected:
          internet=false;
          GetStorage().write('connect', false);
          print('You are disconnected from the internet.');
          break;
      }

    });


    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(Duration(milliseconds: 500));
    await listener.cancel();

    update();
  }
  int currentindex=0;
   void changecurrentindex(index){
     currentindex=index;
     update();

   }


}



