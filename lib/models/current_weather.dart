import 'Main_whether.dart';
import 'clouds.dart';
import 'coord.dart';
import 'sys.dart';
import 'wheather.dart';
import 'wind.dart';


class CurrentWeather {
  CurrentWeather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  late final Coord ?coord;
  late final List<Weather> ?weather;
  late final String? base;
  late final Main? main;
  late final int? visibility;
  late final Wind? wind;
  late final Clouds? clouds;
  late final int? dt;
  late final Sys? sys;
  late final int ?timezone;
  late final int? id;
  late final String? name;
  late final int? cod;

  CurrentWeather.fromJson(Map<String, dynamic> json){
    coord = Coord.fromJson(json['coord']);
    weather = List.from(json['weather']).map((e)=>Weather.fromJson(e)).toList();
    base = json['base'];
    main = Main.fromJson(json['main']);
    visibility = json['visibility'];
    wind = Wind.fromJson(json['wind']);
    clouds = Clouds.fromJson(json['clouds']);
    dt = json['dt'];
    sys = Sys.fromJson(json['sys']);
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coord'] = coord?.toJson();
    _data['weather'] = weather?.map((e)=>e.toJson()).toList();
    _data['base'] = base;
    _data['main'] = main?.toJson();
    _data['visibility'] = visibility;
    _data['wind'] = wind!.toJson();
    _data['clouds'] = clouds!.toJson();
    _data['dt'] = dt;
    _data['sys'] = sys?.toJson();
    _data['timezone'] = timezone;
    _data['id'] = id;
    _data['name'] = name;
    _data['cod'] = cod;
    return _data;
  }
}











