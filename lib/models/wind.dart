class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });
  late final double? speed;
  late final double? deg;
  late final double? gust;

  Wind.fromJson(Map<String, dynamic> json){
    speed = (json['speed']!=null)?double.parse(json['speed'].toString()):null;
    deg =(json['deg']!=null)?double.parse(json['deg'].toString()):null;
    gust = (json['gust']!=null)?double.parse(json['gust'].toString()):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['speed'] = speed;
    _data['deg'] = deg;
    _data['gust'] = gust;
    return _data;
  }
}