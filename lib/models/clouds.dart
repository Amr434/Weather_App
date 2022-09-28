class Clouds {
  Clouds({
    required this.all,
  });
  late final int? all;

  Clouds.fromJson(Map<String, dynamic> json){
    all = (json['all']!=null)?int.parse(json['all'].toString()):null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['all'] = all;
    return _data;
  }
}