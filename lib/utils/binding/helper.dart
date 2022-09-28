import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whether_app/controler/homecontroler.dart';
import 'package:whether_app/repository/homRepository.dart';
import 'package:whether_app/shared/constant/appconstant.dart';

import '../../api/apiclient.dart';

class init extends Bindings {




  @override
  void dependencies() async{
    // TODO: implement dependencies

      Get.lazyPut(() => Apiclient(baseurl: Appconst.BASEURL));
      Get.lazyPut(() => HomRepo(apiclient: Get.find()));
      Get.lazyPut(() => Homecontroler(homRepo: Get.find()));
      Get.find<Homecontroler>().getcurrentdata(Appconst.city??'Dairut');
      Get.find<Homecontroler>().getuserProfile(uid: Appconst.uid!);

  }





  /*  {
        coord:
         {lon: 31.2497, lat: 30.0626},
          weather: [{id: 800, main: Clear, description: clear sky, icon: 01d}],
           base: stations,
            main: {temp: 303.57, feels_like: 302.76, temp_min: 303.38, temp_max: 303.57, pressure: 1010, humidity: 35}
            ,
            visibility: 10000,
             wind: {speed: 3.09, deg: 270},
              clouds: {all: 0},
            dt: 1663672336,
            sys: {type: 1, id: 2514, country: EG, sunrise: 1663645325, sunset: 1663689305}
            , timezone: 7200, id: 360630, name: Cairo, cod: 200}
*/
    /*
    {coord: {lon: 44.1496, lat: 16.0505},
    weather: [{id: 803, main: Clouds, description: broken clouds, icon: 04d}],
     base: stations,
      main: {temp: 298.49, feels_like: 297.76, temp_min: 298.49, temp_max: 298.49, pressure: 1009, humidity: 26, sea_level: 1009, grnd_level: 778},
       visibility: 10000, wind: {speed: 3.83, deg: 10, gust: 4.51}, clouds: {all: 82},
     dt: 1663672558,
     sys: {country: YE, sunrise: 1663642332, sunset: 1663686108},
      timezone: 10800,
       id: 76147,
        name: Saudan,
         cod: 200}*/



}