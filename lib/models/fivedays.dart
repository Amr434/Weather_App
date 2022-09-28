import 'package:flutter/material.dart';

import 'Main_whether.dart';
import 'clouds.dart';
import 'wheather.dart';

class FiveDays{
   final int datetime;
   final Main ? main ;
   final String dt_txt;
   final List<Weather> wheather;
   final Clouds  ?clouds;
   FiveDays({

     required this.dt_txt,
     required this.datetime,
     required this.main,
     required this.wheather,
     required this.clouds

   });

factory FiveDays.fromjson(Map<String ,dynamic>json){
     return FiveDays(

         datetime: json['dt'],
         main: json['main']!=null? Main.fromJson(json['main']):null,
         dt_txt: json['dt_txt'],
         wheather: List.from(json['weather']).map((e)=>Weather.fromJson(e)).toList(),
         clouds: Clouds.fromJson(json['clouds'])
     );

   }


   Map<String ,dynamic>tojson(){
  return {
    'datetime':this.datetime,
    'temp':this.main,
    'dt_txt':this.dt_txt
  };
   }
   

}